class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :about
      t.text :certifications
      t.string :address
      t.string :phone_number
      t.string :web

      t.timestamps
    end
  end
end
