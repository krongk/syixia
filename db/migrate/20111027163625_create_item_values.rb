class CreateItemValues < ActiveRecord::Migration
  def change
    create_table :item_values do |t|
      t.references :item
      t.integer :engine_value,    :default => 0
      t.integer :click_value,     :default => 0
      t.integer :recommend_value, :default => 0
      t.integer :user_value,      :default => 0
      t.integer :manual_value,    :default => 0

      t.timestamps
    end
    add_index :item_values, :item_id
  end
end