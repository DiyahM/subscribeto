class AddNoteToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :note, :text
  end
end
