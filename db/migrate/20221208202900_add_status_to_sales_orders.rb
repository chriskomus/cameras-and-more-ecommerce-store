class AddStatusToSalesOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :sales_orders, :status, :string
  end
end
