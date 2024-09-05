require 'net/https'

class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :published_posts

  RECAPTCHA_MINIMUM_SCORE = 0.5

  def published_posts
    @active_posts = if params[:show_draft].present?
                      #params.merge!(show_draft: true)
                      Post.unpublished
                    else
                      Post.published
                    end

    @shelves = Shelf.select(:id, :slug, :name).includes(:posts)
    ActiveRecord::Associations::Preloader.new(
      records: @shelves, associations: :posts, scope:  Post.where(is_box: true)
    ).call

    @shelves.each do |shelf|
      shelf.posts
    end
  end

  def verify_recaptcha?(token, recaptcha_action)
    secret_key = ENV['RECAPTACH_SECRET_KEY']

    uri = URI.parse("https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{token}")
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)
    json['success'] && json['score'] > RECAPTCHA_MINIMUM_SCORE && json['action'] == recaptcha_action
  end

  def parse_boolean(value)
    ActiveRecord::Type::Boolean.new.deserialize(value)
  end
end
