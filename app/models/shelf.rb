class Shelf < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :posts, -> { where( published: true ) }

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
    posts.where(parent_box_id: box_id)
  end
end
