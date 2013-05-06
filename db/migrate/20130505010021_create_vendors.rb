class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :contact_name
      t.text :address
      t.string :phone
      t.string :email
      t.text :notes

      t.timestamps
    end
  end
end
