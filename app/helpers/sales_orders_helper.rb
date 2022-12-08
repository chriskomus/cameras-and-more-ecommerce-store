module SalesOrdersHelper
  def calc_subtotal(sales_order)
    sales_order_details = SalesOrderDetail.where(sales_order_id: sales_order.id)

    subtotal = 0
    sales_order_details.each do |sales_order_detail|
      subtotal += sales_order_detail.price * sales_order_detail.quantity
    end

    subtotal
  end
end
