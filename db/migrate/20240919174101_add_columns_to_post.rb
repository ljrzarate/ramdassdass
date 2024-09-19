class AddColumnsToPost < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :is_private, :boolean, default: false
    add_column :posts, :price_cents, :integer, default: 0
  end
end
