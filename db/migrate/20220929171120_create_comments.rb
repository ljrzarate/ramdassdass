class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :post_id, null: false
      t.string :name, null: false, default: ""
      t.text :content, null: false, default: ""

      t.timestamps
    end
  end
end
