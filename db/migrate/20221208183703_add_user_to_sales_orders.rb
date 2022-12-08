class AddUserToSalesOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :sales_orders, :user, null: false, foreign_key: true
  end
end
