ActiveAdmin.register Category, as: "Product Category" do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description

  index do
    selectable_column
    id_column
    column :title
    column :products
    actions
  end

  show do |category|
    attributes_table do
      row :id
      row :title
      row :description
    end

    table_for category.products do
      column :sku do |product|
        link_to product.sku, admin_product_path(product)
      end
      column :title
      column :description
      column :list_price
      column :price
      column :created_at
      column :updated_at
    end
  end

  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
