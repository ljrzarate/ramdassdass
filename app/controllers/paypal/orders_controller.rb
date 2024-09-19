require 'rest-client'

class Paypal::OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @access_token = get_paypal_access_token
    if @access_token
      order_id = create_paypal_order
      if order_id.present?
        respond_to do |format|
          json_response = { status: :ok, id:  order_id}
          format.json  { render json: json_response }
        end
      end

      # if order_id.present?
      #   url = "https://api-m.sandbox.paypal.com/v2/checkout/orders/#{order_id}/capture"
      #   headers = {
      #     "Content-Type" => "application/json",
      #     "Authorization" => "Bearer #{@access_token}"
      #   }

      #   response = RestClient.post(url, {}.to_json, headers)
      #   response_body = JSON.parse(response.body).with_indifferent_access
      # end
    end
  end

  private

  def paypal_order_params
    params.permit(cart: [:sku, :quantity, :donation_value])
  end

  def create_paypal_order
    paypal_order_id = nil
    url = "https://api-m.sandbox.paypal.com/v2/checkout/orders"
    purchase_units = []
    paypal_order_params[:cart].each do |item|
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
            "return_url": "https://example.com/returnUrl",
            "cancel_url": "https://example.com/cancelUrl"
          }
        }
      }
    }.to_json

    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{@access_token}"
    }

    response = RestClient.post(url, payload, headers)
    response_body = JSON.parse(response.body).with_indifferent_access
    if response.code == 200 || response.code == 201
      paypal_order_id = response_body[:id]
    end
    paypal_order_id
  end

  def get_paypal_access_token
    access_token = nil
    url = "https://api-m.sandbox.paypal.com/v1/oauth2/token"
    payload = {
      grant_type: 'client_credentials'
    }
    headers = {
      "Authorization" => "Basic " + Base64.strict_encode64("#{ENV['PAYPAL_CLIENT_ID']}:#{ENV['PAYPAL_SECRET_KEY']}"),
      "Content-Type" => "application/x-www-form-urlencoded"
    }
    response = RestClient.post(url, payload, headers)
    response_body = JSON.parse(response.body).with_indifferent_access
    if response.code == 200 || response.code == 201
      access_token = response_body[:access_token]
    end
    access_token
  end
end