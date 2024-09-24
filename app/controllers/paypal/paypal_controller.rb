require 'rest-client'

class Paypal::PaypalController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_access_token

  def set_access_token
    @access_token = Paypal::Token.new.refresh
  end
end