class CreateKeyWords < ActiveRecord::Migration
  def change
    create_table :key_words do |t|
      t.references :engine
      t.references :cate
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :key_words, :engine_id
    add_index :key_words, :cate_id
  end
end
