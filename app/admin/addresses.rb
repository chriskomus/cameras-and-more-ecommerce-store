ActiveAdmin.register Address do
  menu false

  show do |address|
    attributes_table do
      row :company
      row :address_one
      row :address_two
      row :city
      row :postal_code
      row :province
      row :country
      row :email
      row :website
      row :phone
      row :fax
      row :notes
      row :user
    end
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :email, :website, :phone, :fax, :company, :address_one, :address_two, :city, :province, :postal_code, :country, :notes
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :website, :phone, :fax, :company, :address_one, :address_two, :city, :province, :postal_code, :country, :notes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
