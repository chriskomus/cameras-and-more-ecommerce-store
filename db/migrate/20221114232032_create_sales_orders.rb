class CreateSalesOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :sales_orders do |t|
      t.string :order_number
      t.string :tracking_number
      t.decimal :shipping
      t.decimal :prov_tax
      t.decimal :fed_tax
      t.date :due_date
      t.date :order_date

      t.timestamps
    end
  end
end
