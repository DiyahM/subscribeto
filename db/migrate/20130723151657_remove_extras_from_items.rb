class RemoveExtrasFromItems < ActiveRecord::Migration
  def up
    remove_column :items, :image_url
    remove_column :items, :item_type
    remove_column :items, :spec_number
    remove_column :items, :pricing_unit
    remove_column :items, :vendor_id
  end

  def down
    add_column :items, :vendor_id, :string
    add_column :items, :pricing_unit, :string
    add_column :items, :spec_number, :string
    add_column :items, :item_type, :string
    add_column :items, :image_url, :string
  end
end
