class CreateSalesOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :sales_order_details do |t|
      t.integer :quantity
      t.decimal :price
      t.boolean :shipped

      t.timestamps
    end
  end
end
