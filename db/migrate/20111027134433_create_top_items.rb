class CreateTopItems < ActiveRecord::Migration
  def change
    create_table :top_items do |t|
      t.references :top_cate
      t.string :key_word
      t.integer :item_index
      t.string :trend
      t.integer :today_value
      t.integer :seven_value
      t.integer :avg_value
      t.integer :manual_value, :default => 0

      t.timestamps
    end

    add_index :top_items, :key_word
    add_index :top_items, [:key_word, :item_index]
  end
end
