class Post < ApplicationRecord
  CAMINO_ZERO = 'camino_0'
  CUENTOS = 'cuentos'

  extend FriendlyId
  friendly_id :title, use: :slugged
  attr_accessor :remove_main_image
  acts_as_taggable_on :tags

  has_one_attached :main_image
  has_many_attached :images
  has_many :comments

  scope :published, lambda { where(published: true) }
  scope :unpublished, lambda { where(published: false) }

  validates :title, presence: true
end
