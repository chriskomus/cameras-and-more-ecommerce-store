ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :name

  show do |user|
    attributes_table do
      row :id
      row :name
      row :email
    end

    table_for user.addresses do
      column :name do |address|
        link_to address.name, admin_address_path(address)
      end
      column :company
      column :address_one
      column :address_two
      column :city
      column :postal_code
      column :province
      column :country
      column :email
      column :website
      column :phone
      column :fax
      column :notes
    end

    table_for user.sales_orders do
      column :order_number do |sales_order|
        link_to sales_order.order_number, admin_sales_order_path(sales_order)
      end
      column :shipping
      column :prov_tax
      column :fed_tax
      column :address
      column :status
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :created_at
    column :addresses
    column :sales_orders
    actions
  end

  filter :name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end