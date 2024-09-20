require 'rest-client'

class Paypal::PaypalController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_access_token

  def set_access_token
    @access_token = nil
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
      @access_token = response_body[:access_token]
    end
   @access_token
  end
end