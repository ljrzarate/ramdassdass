require 'rest-client'

class Paypal::OrdersController < Paypal::PaypalController

  def create
    order_id = create_paypal_order
    if order_id.present?
      respond_to do |format|
        json_response = { status: :ok, id:  order_id}
        format.json  { render json: json_response }
      end
    end
  end

  private

  def paypal_order_params
    params.permit(:post_id, cart: [:sku, :quantity, :donation_value])
  end

  def create_paypal_order
    paypal_order_id = Paypal::Order.new(
      params: paypal_order_params,
      access_token: @access_token
    ).create

    session[:paypal_order_id] = paypal_order_id
  end
end