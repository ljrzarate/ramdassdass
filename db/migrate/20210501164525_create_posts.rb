class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content, null: false, default: ""
      t.string :title, null: false, default: ""
      t.text :summary, default: ""

      t.timestamps
    end
  end
end
