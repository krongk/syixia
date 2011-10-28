class CreateCates < ActiveRecord::Migration
  def change
    create_table :cates do |t|
      t.string :name
      t.integer :parent_id, :default => 0

      t.timestamps
    end
    #define the root cate
    Cate.create!(:name => 'syixia')
    add_index :cates, :name
  end
end

# cate 即为了满足人工目录分类而设立
# syixia下所有的目录，即以'syixia'为根目录
# |syixia
#       |IT
#       |财经
#            |股票
#            |基金