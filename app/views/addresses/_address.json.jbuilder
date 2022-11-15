json.extract! address, :id, :name, :email, :website, :phone, :fax, :company, :address_one, :address_two, :city, :province, :postal_code, :country, :notes, :created_at, :updated_at
json.url address_url(address, format: :json)
