class AddColumnToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :is_box, :boolean, default: false
    add_column :posts, :parent_box_id, :integer
    add_column :posts, :shelf_id, :integer
  end
end
