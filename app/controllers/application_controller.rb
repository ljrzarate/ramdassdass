require 'net/https'

class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :published_posts

  RECAPTCHA_MINIMUM_SCORE = 0.5

  def published_posts
    @active_posts = params[:show_draft].present? ? Post.unpublished : Post.published

    @camino_0_count = Post.camino_0_count
    @cuentos_count = Post.cuentos_count
  end

  def verify_recaptcha?(token, recaptcha_action)
    secret_key = ENV['RECAPTACH_SECRET_KEY']

    uri = URI.parse("https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{token}")
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)
    json['success'] && json['score'] > RECAPTCHA_MINIMUM_SCORE && json['action'] == recaptcha_action
  end
end
