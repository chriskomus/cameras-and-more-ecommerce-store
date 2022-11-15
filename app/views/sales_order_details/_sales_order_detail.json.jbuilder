json.extract! sales_order_detail, :id, :quantity, :price, :shipped, :created_at, :updated_at
json.url sales_order_detail_url(sales_order_detail, format: :json)
