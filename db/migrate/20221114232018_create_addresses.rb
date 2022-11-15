class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :email
      t.string :website
      t.string :phone
      t.string :fax
      t.string :company
      t.string :address_one
      t.string :address_two
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :country
      t.string :notes

      t.timestamps
    end
  end
end
