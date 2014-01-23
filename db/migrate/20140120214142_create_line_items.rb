class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :order_id
      t.integer :line_num
      t.integer :product_id
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :line_total

      t.timestamps
    end
  end
end
