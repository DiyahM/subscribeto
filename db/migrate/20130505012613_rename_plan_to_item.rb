class RenamePlanToItem < ActiveRecord::Migration
  def change
    rename_table :plans, :items 
  end

end
