class Post < ApplicationRecord
  monetize :price_cents

  CAMINO_ZERO = 'camino_0'
  CUENTOS = 'cuentos'

  extend FriendlyId
  friendly_id :title, use: :slugged
  attr_accessor :remove_main_image
  acts_as_taggable_on :tags

  belongs_to :parent_box, optional: true, class_name: "Post", foreign_key: :parent_box_id
  belongs_to :shelf

  has_one_attached :main_image
  has_many_attached :images
  has_many :comments

  scope :published, lambda { where(published: true, is_box: false) }
  scope :unpublished, lambda { where(published: false, is_box: false) }

  validates :title, presence: true
  validate :is_box_with_no_parent

  def self.camino_0_count
    Post.published.tagged_with(CAMINO_ZERO).count
  end

  def self.cuentos_count
    Post.published.tagged_with(CUENTOS).count
  end

  def shelf_name
    self.shelf.name
  end

  def parent_box_name
    self.parent_box&.title
  end

  def price_with_dolar_sign
    humanized_money_with_symbol(self.price)
  end

  private

  def is_box_with_no_parent
    self.errors.add(:base, "Only non-boxes can have parent.") if self.is_box? && self.parent_box_id.present?
  end

end
