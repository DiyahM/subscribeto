class AddAttributesToItems < ActiveRecord::Migration
  def change
    add_column :items, :item_type, :string
    add_column :items, :spec_number, :string
    add_column :items, :name, :string
    add_column :items, :description, :text
    add_column :items, :pricing_unit, :string
  end
end
