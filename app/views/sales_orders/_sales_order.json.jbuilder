json.extract! sales_order, :id, :order_number, :tracking_number, :shipping, :prov_tax, :fed_tax, :due_date, :order_date, :created_at, :updated_at
json.url sales_order_url(sales_order, format: :json)
