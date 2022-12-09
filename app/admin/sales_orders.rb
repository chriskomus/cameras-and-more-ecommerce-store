ActiveAdmin.register SalesOrder do
  # belongs_to :address
  # belongs_to :user

  show do |sales_order|
    attributes_table do
      row :order_number
      row :shipping
      row "PST", :prov_tax
      row "GST/HST", :fed_tax
      row :address
      row :status
    end

    div class: 'panel' do
      h3 'Items in Order'
      div class: 'attributes_table' do
        table do
          tr do
            th 'Title'
            th 'Quantity'
            th 'Price'
          end
          sales_order.sales_order_details.each do |sales_order_detail|
            tr do
              td Product.find_by_id(sales_order_detail.product_id).title
              td sales_order_detail.quantity
              td sales_order_detail.price
            end
          end
        end
      end
    end
  end

  sidebar "Order Items", only: [:show, :edit] do
    ul do
      li link_to "Details", admin_sales_order_sales_order_details_path(resource)
    end
  end

  index do
    selectable_column
    id_column
    column :order_number
    column :shipping
    column "PST", :prov_tax
    column "GST/HST", :fed_tax
    column :created_at
    column :updated_at
    column :address
    column :user
    column :status
    actions
  end

  controller do
    def scoped_collection
      SalesOrder.includes(:user)
      SalesOrder.includes(:address)
    end
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :order_number, :tracking_number, :shipping, :prov_tax, :fed_tax, :due_date, :order_date, :address_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:order_number, :tracking_number, :shipping, :prov_tax, :fed_tax, :due_date, :order_date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
