require 'rest-client'

class Paypal::CapturesController < Paypal::PaypalController
  def create
    if paypal_order_params[:order_id].present?
      post = Post.find_by(id: paypal_order_params[:post_id])

      if post.present?
        url = "https://api-m.sandbox.paypal.com/v2/checkout/orders/#{paypal_order_params[:order_id]}/capture"
        headers = {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{@access_token}"
        }

        response = RestClient.post(url, {}.to_json, headers)
        response_body = JSON.parse(response.body).with_indifferent_access

        Rails.logger.info "*" * 40
        Rails.logger.info response_body
        Rails.logger.info "*" * 40
        @user = create_and_login_user_from_paypay(response_body)

        if response.code == 200 || response.code == 201
          paypal_order = Order.find_by(
            token: session[:paypal_order_id],
            post_id: post.id,
            status: Order.statuses[:pending]
          )
          paypal_order.user_id = @user.id
          paypal_order.status = Order.statuses[:paypal_executed]
          paypal_order.charge_id = response_body[:id]
          paypal_order.payment_gateway = :paypal

          paypal_order.save!
          respond_to do |format|
            format.json  { render json: response_body }
          end
        end
      end
    end
  end

  private

  def create_and_login_user_from_paypay(response_body)
    user = User.find_or_initialize_by(email: response_body[:payer][:email_address])
    if user.new_record?
      user.payer_id              = response_body[:payer][:payer_id]
      user.password              = response_body[:payer][:payer_id]
      user.password_confirmation = response_body[:payer][:payer_id]
      user.first_name            = response_body[:payer][:name][:given_name]
      user.last_name             = response_body[:payer][:name][:surname]
      user.save!
      WelcomeEmailJob.perform_later(user.id)
    end
    sign_in(user)
    user
  end

  def payer_object(response_body)
    OpenStruct.new(
      email:    response_body[:payer][:email_address]
    )
  end

  def paypal_order_params
    params.permit(:order_id, :post_id)
  end
end