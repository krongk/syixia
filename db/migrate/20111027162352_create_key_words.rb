class CreateKeyWords < ActiveRecord::Migration
  def change
    create_table :key_words do |t|
      t.references :engine
      t.references :cate, :default => 1
      t.integer :parent_id, :default => 0
      t.string :name

      t.timestamps
    end
    add_index :key_words, :engine_id
    add_index :key_words, :cate_id
  end
end

#Key Word => cate 默认未人工分类情况下，都属于根目录'syixia'
#parent_id = 0 即此关键词为根关键词（即没有相关的父级关键词）
#