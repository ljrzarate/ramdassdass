class Paypal::Token
  URL = "#{ENV['PAYPAL_BASE_API_URL']}" + "/v1/oauth2/token"

  attr_reader :paypal_client_id, :paypal_secret_key

  def initialize
    @paypal_client_id = ENV['PAYPAL_CLIENT_ID']
    @paypal_secret_key = ENV['PAYPAL_SECRET_KEY']
  end

  def refresh
    response = RestClient.post(URL, payload, headers)
    response_body = JSON.parse(response.body).with_indifferent_access

    if response.code == 200 || response.code == 201
      access_token = response_body[:access_token]
    end

   access_token
  end

  private

  def headers
    {
      "Authorization" => "Basic " + Base64.strict_encode64("#{paypal_client_id}:#{paypal_secret_key}"),
      "Content-Type" => "application/x-www-form-urlencoded"
    }
  end

  def payload
    {
      grant_type: 'client_credentials'
    }
  end
end