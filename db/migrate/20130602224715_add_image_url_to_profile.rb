class AddImageUrlToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :image_url, :string
  end
end
