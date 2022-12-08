class AddProductToSalesOrderDetails < ActiveRecord::Migration[7.0]
  def change
    add_reference :sales_order_details, :product, null: false, foreign_key: true
  end
end
