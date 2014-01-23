class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :address_id
      t.decimal :sub_total
      t.decimal :sales_tax
      t.decimal :grand_total

      t.timestamps
    end
  end
end
