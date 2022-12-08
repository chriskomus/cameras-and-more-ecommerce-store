ActiveAdmin.register SalesOrderDetail do
  belongs_to :sales_order

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :quantity, :price, :shipped
  #
  # or
  #
  # permit_params do
  #   permitted = [:quantity, :price, :shipped]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
