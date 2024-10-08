class Shelf < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :posts, -> { where( published: true ) }

  def self.tagged_with(tag)
    where(slug: tag)
  end

  def title_to_show_on_main_banner
    self.name
  end

  def image_to_show_on_main_banner
    nil
  end

  def posts_non_boxes
    posts.where(is_box: false)
  end

  def posts_non_boxes_non_parent
    posts.where(is_box: false, parent_box_id: nil)
  end

  def count_posts
    Post.published.where(shelf_id: self.id).count
  end

  def count_only_boxes
    Post.published.where(shelf_id: self.id, is_box: true).count
  end

  def boxes
    ActiveRecord::Associations::Preloader.new(
      records: [self], associations: :posts, scope:  Post.where(is_box: true)
    ).call
    posts.where(is_box: true)
  end

  def posts_by_parent_box(box_id)
    ActiveRecord::Associations::Preloader.new(
      records: [self], associations: :posts, scope:  Post.where(is_box: true)
    ).call
    posts.where(parent_box_id: box_id)
  end
end
