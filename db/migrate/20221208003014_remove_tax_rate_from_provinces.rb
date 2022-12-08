class RemoveTaxRateFromProvinces < ActiveRecord::Migration[7.0]
  def change
    remove_column :provinces, :taxRate, :decimal
  end
end
