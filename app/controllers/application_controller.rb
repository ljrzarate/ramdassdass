require 'net/https'

class ApplicationController < ActionController::Base
  RECAPTCHA_MINIMUM_SCORE = 0.5

  def verify_recaptcha?(token, recaptcha_action)
    secret_key = ENV['RECAPTACH_SECRET_KEY']

    uri = URI.parse("https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{token}")
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)
    json['success'] && json['score'] > RECAPTCHA_MINIMUM_SCORE && json['action'] == recaptcha_action
  end
end
