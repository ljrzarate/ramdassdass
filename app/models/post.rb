class Post < ApplicationRecord
  attr_accessor :remove_main_image

  has_one_attached :main_image
  has_many_attached :images
  has_many :comments

  scope :published, lambda { where(published: true) }
  scope :unpublished, lambda { where(published: false) }

  validates :title, presence: true
end
