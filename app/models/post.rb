class Post < ApplicationRecord
  has_one_attached :main_image
  has_many_attached :images

  attr_accessor :remove_main_image

  #validates :content, presence: true
  validates :title, presence: true
end
