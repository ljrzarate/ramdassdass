class AddPublishedToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :published, :boolean, default: false
  end
end
