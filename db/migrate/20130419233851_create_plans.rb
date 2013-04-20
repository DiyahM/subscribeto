class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :plan_code
      t.string :plan_name
      t.text :plan_description
      t.integer :price
      t.string :frequency
      t.string :image_url

      t.timestamps
    end
  end
end
