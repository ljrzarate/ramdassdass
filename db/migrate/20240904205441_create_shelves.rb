class CreateShelves < ActiveRecord::Migration[7.2]
  def change
    create_table :shelves do |t|
      t.string :name
      t.string :slug

      t.timestamps
      t.index :slug, unique: true
    end
  end
end
