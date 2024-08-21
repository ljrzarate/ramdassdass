class AddPublishedToPost < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :published, :boolean, default: false
  end
end
