ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :sku, :description, :price, :quantity, :list_price, category_ids: [], product_categories_attributes: [:id, :product_id, :category_id, :_destroy]


  form do |f|
    f.actions
    f.inputs 'Categories' do
      f.input :categories, :as => :select, :input_html => {:multiple => true}
      f.input :title
      f.input :sku
      f.input :description
      f.input :quantity
      f.input :price
      f.input :list_price
    end
    f.actions
  end

  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :sku, :description, :price, :quantity]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
