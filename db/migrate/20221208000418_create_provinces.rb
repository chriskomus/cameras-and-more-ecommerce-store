class CreateProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :provinces do |t|
      t.decimal :taxRate

      t.timestamps
    end
  end
end
