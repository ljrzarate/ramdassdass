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
    post = Post.find_by(id: paypal_order_params[:post_id])
    paypal_order_id = nil
    url = "https://api-m.sandbox.paypal.com/v2/checkout/orders"
    purchase_units = []
    total_donation = 0

    paypal_order_params[:cart].each do |item|
      total_donation += item[:donation_value].to_f
      item_hash = {
        "amount": {
          "currency_code": "USD",
          "value": item[:donation_value]
        },
        "reference_id": item[:sku]
      }
      purchase_units << item_hash
    end

    payload = {
      "purchase_units": purchase_units,
      "intent": "CAPTURE",
      "payment_source": {
        "card": {
          "experience_context": {
            "payment_method_preference": "IMMEDIATE_PAYMENT_REQUIRED",
            "brand_name": "Ramminti",
            "locale": "en-US",
            "landing_page": "LOGIN",
            "shipping_preference": "NO_SHIPPING",
            "user_action": "PAY_NOW",
            "return_url": post_url(post.friendly_id),
            "cancel_url": post_url(post.friendly_id)
          }
        }
      }
    }.to_json

    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{@access_token}"
    }

    if post.present?
      response = RestClient.post(url, payload, headers)
      response_body = JSON.parse(response.body).with_indifferent_access
      if response.code == 200 || response.code == 201
        paypal_order_id = response_body[:id]
        session[:paypal_order_id] = paypal_order_id
        Order.create!(
          token: paypal_order_id,
          post_id: post.id,
          status: Order.statuses[:pending],
          price_cents: (100 * total_donation.to_r).to_i # Convert dollars to cents
        )
      end
    end
    paypal_order_id
  end
end