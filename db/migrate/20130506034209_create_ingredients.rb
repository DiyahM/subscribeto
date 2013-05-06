class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.integer :raw_id
      t.integer :prepared_id
      t.decimal :quantity, :precision => 8, :scale => 3

      t.timestamps
    end
  end
end
