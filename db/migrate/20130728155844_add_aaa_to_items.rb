class AddAaaToItems < ActiveRecord::Migration
  def change
    add_column :items, :archive_number, :string
    add_column :items, :archived_at, :datetime
  end
end
