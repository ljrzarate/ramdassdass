class AddParentBoxToPosts < ActiveRecord::Migration[7.2]
  def up
    posts = Post.tagged_with('cuentos')
    shelf = Shelf.find_by(slug: 'camino-uno')
    parent_box = Post.find_or_create_by(is_box: true, slug: 'cuentos', shelf_id: shelf.id, title: 'cuentos')
    posts.each do |post|
      post.parent_box_id = parent_box.id
      post.save!
    end
  end

  def down
    parent_box = Post.find_by(is_box: true, slug: 'cuentos')
    Post.where(parent_box_id: parent_box.id).update_all(parent_box_id: nil) if parent_box.present?
  end
end
