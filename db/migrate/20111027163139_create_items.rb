class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :key_word
      t.references :cate,   :default => 1
      t.string :title
      t.string :url
      t.date :updated_date
      t.text :summary
      t.integer :item_index
      t.string :cached_url
      t.boolean :is_display, :default => true

      t.timestamps
    end
    add_index :items, :key_word_id
    add_index :items, :cate_id
    add_index :items, [:key_word_id, :title], :uniqe => true
    add_index :items, :url, :uniqe => true
  end
end
