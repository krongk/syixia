# encoding: utf-8
class CreateTopCates < ActiveRecord::Migration
  def change
    create_table :top_cates do |t|
      t.string :engine
      t.string :cate_name
      t.string :name
      t.string :url
      t.boolean :is_valid, :default => true

      t.timestamps
    end
    #add init 
    TopCate.create!(:engine => 'baidu', :cate_name => 'book', :name => '百度网络小说排行', :url => 'http://top.baidu.com/buzz.php?p=book')

    add_index :top_cates, :name
  end
end
