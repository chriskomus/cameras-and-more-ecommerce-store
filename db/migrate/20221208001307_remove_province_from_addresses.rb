class RemoveProvinceFromAddresses < ActiveRecord::Migration[7.0]
  def change
    remove_column :addresses, :province, :string
  end
end
