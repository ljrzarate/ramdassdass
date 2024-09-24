class Paypal::Capture
  URL = "https://api-m.sandbox.paypal.com/v2/checkout/orders/__:id__/capture"

  attr_reader :post, :params, :order_id

  def initialize(params: {})
    @access_token = params[:access_token]
    @params = params
    @post = Post.find_by(id: params[:post_id])
    @order_id = params[:order_id]
  end

  def execute
    return unless order_id.present?
    return unless post.present?

    url = URL.gsub("__:id__", order_id)
    response = RestClient.post(url, {}.to_json, headers)
    response_body = JSON.parse(response.body).with_indifferent_access

    if response.code == 200 || response.code == 201

      user = create_and_login_user_from_paypay(response_body[:payer])
      charge_id = response_body[:purchase_units][0][:payments][:captures][0][:id] # uff
      find_and_update_order_record_for(user: user, charge_id: charge_id)

      {
        user: user,
        paypal_response: response_body
      }

    end
  end

  private

  def find_and_update_order_record_for(user:, charge_id:)
    order = Order.find_by(
      token: order_id,
      post_id: post.id,
      status: Order.statuses[:pending]
    )

    order.user_id = user.id
    order.status = Order.statuses[:paypal_executed]
    order.charge_id = charge_id
    order.payment_gateway = :paypal
    order.save!
    order
  end

  def create_and_login_user_from_paypay(user_data_from_paypal)
    user = User.find_or_initialize_by(email: user_data_from_paypal[:email_address])
    if user.new_record?
      user.payer_id              = user_data_from_paypal[:payer_id]
      user.password              = user_data_from_paypal[:payer_id]
      user.password_confirmation = user_data_from_paypal[:payer_id]
      user.first_name            = user_data_from_paypal[:name][:given_name]
      user.last_name             = user_data_from_paypal[:name][:surname]
      user.save!
      WelcomeEmailJob.perform_later(user.id)
    end
    user
  end

  def headers
    {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{@access_token}"
    }
  end
end