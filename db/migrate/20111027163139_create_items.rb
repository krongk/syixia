class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :key_word
      t.references :cate
      t.string :title
      t.string :url
      t.date :updated_date
      t.text :summary
      t.integer :item_index
      t.string :chached_url
      t.boolean :is_display

      t.timestamps
    end
    add_index :items, :key_word_id
    add_index :items, :cate_id
  end
end
