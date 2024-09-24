class Paypal::Order
  URL = "https://api-m.sandbox.paypal.com/v2/checkout/orders"
  include Rails.application.routes.url_helpers

  attr_reader :params, :post

  def initialize(params: {}, access_token: nil)
    @params = params
    @post = Post.find_by(id: params[:post_id])
    @access_token = access_token
  end

  def create
    paypal_order_id = nil
    if post.present?
      response_from_paypal = create_order_on_paypal
      if response_from_paypal.code == 200 || response_from_paypal.code == 201
        paypal_order_id = response_from_paypal[:id]
        create_order_record(paypal_order_id)
      end

    end
    paypal_order_id
  end

  private

  def create_order_record(paypal_order_id)
    Order.create!(
      token: paypal_order_id,
      post_id: post.id,
      status: Order.statuses[:pending],
      price_cents: (100 * total_donation.to_r).to_i # Convert dollars to cents
    )
  end

  def create_order_on_paypal
    response = RestClient.post(URL, payload, headers)
    response_body = OpenStruct.new(JSON.parse(response.body).with_indifferent_access.merge(code: response.code))
    response_body
  end

  def headers
    {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{@access_token}"
    }
  end

  def purchase_units
    purchase_units = []
    params[:cart].each do |item|
      item_hash = {
        "amount": {
          "currency_code": "USD",
          "value": item[:donation_value]
        },
        "reference_id": item[:sku]
      }

      purchase_units << item_hash
    end
    purchase_units
  end

  def total_donation
    total_donation = 0
    params[:cart].each { |item| total_donation += item[:donation_value].to_f }
    total_donation
  end

  def payload
    {
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
  end
end