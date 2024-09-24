require 'rest-client'

class Paypal::CapturesController < Paypal::PaypalController
  def create
    params_to_service = paypal_order_params.merge(
      {
        access_token: @access_token,
        session_paypal_order_id: session[:paypal_order_id]
      }
    )
    capture = Paypal::Capture.new(params: params_to_service).execute
    sign_in(capture[:user])

    respond_to do |format|
      format.json  { render json: capture[:paypal_response] }
    end
  end

  private

  def payer_object(response_body)
    OpenStruct.new(
      email:    response_body[:payer][:email_address]
    )
  end

  def paypal_order_params
    params.permit(:order_id, :post_id)
  end
end