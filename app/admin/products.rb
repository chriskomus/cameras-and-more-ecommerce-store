ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :sku, :description, :price, :quantity, :list_price, :main_image, category_ids: [], product_categories_attributes: [:id, :product_id, :category_id, :_destroy]

  form do |f|
    f.actions
    f.inputs do
      f.input :categories, :as => :select, :input_html => { :multiple => true }

      f.input :title
      f.input :sku
      f.input :description, as: :froala_editor
      f.input :quantity
      f.input :price
      f.input :list_price
      f.input :main_image, as: :file
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :sku
    column :description
    column :quantity
    column :price
    column :list_price
    column :categories
  end

  show do
    attributes_table do
      row :title
      row :categories
      if product.main_image.attached?
        row :main_image do
          image_tag url_for(product.main_image), size: "200x200"
        end
      end
      row :sku
      row :description
      row :quantity
      row :price
      row :list_price
    end
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
