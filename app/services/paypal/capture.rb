class Paypal::Capture
  URL = "#{ENV['PAYPAL_BASE_API_URL']}" + "/v2/checkout/orders/__:id__/capture"

  attr_reader :post, :params, :order_id
  attr_accessor :user_creator, :order_updater

  def initialize(params: {}, user_creator: Paypal::Users::Creator, order_updater: Paypal::Orders::Updater)
    @params = params
    @order_id = params[:order_id]
    @access_token = params[:access_token]
    @post = Post.find_by(id: params[:post_id])
    @user_creator = user_creator
    @order_updater = order_updater
  end

  def execute
    return unless order_id.present?
    return unless post.present?

    url = URL.gsub("__:id__", order_id)
    response = RestClient.post(url, {}.to_json, headers)
    response_body = JSON.parse(response.body).with_indifferent_access
    return unless response.code != 200 || response.code != 201

    user = user_creator.new(paypal_attrs: response_body[:payer]).execute

    charge_id = response_body[:purchase_units][0][:payments][:captures][0][:id] # uff

    order_updater.new(
      user_id: user.id,
      charge_id: charge_id,
      order_id: order_id,
      post_id: post.id
    ).execute


    {
      user: user,
      paypal_response: response_body
    }
  end

  private

  def headers
    {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{@access_token}"
    }
  end
end