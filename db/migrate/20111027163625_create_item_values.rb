class CreateItemValues < ActiveRecord::Migration
  def change
    create_table :item_values do |t|
      t.references :item
      t.integer :manual_value
      t.integer :engine_value
      t.integer :click_value
      t.integer :recommend_value
      t.integer :user_value

      t.timestamps
    end
    add_index :item_values, :item_id
  end
end
