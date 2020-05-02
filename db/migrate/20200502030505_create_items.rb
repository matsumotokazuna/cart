class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :detail
      t.integer :genre_id
      t.integer :price
      t.string :image_id
      t.integer :sale_status

      t.timestamps
    end
  end
end
