class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :company_name
      t.string :logo
      t.string :headline
      t.text :description
      t.string :website_url
      t.string :facebook
      t.string :twitter

      t.timestamps
    end
  end
end
