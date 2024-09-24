require 'rest-client'

class Paypal::CapturesController < Paypal::PaypalController
  def create
    capture = Paypal::Capture.new(params: paypal_order_params).execute
    sign_in(capture[:user])

    respond_to do |format|
      format.json  { render json: capture[:paypal_response] }
    end
  end

  private

  def paypal_order_params
    params.permit(:order_id, :post_id).merge({access_token: @access_token})
  end
end