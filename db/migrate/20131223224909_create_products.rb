class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name
      t.text :description
      t.integer :ohb
      t.decimal :price
      t.integer :category_id
      t.string :um

      t.timestamps
    end
  end
end
