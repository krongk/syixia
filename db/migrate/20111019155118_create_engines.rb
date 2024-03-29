# encoding: utf-8
class CreateEngines < ActiveRecord::Migration
  def change
    create_table :engines do |t|
      t.string :name
      t.string :nickname
      t.string :url
      t.string :scope
      t.string :description
      t.boolean :is_valid, :default => true

      t.timestamps
    end
    add_index :engines, :name, :uniqe => true
    
    Engine.create(:name => 'baidu_web', :nickname => '百度搜索', :url => 'http://www.baidu.com', :scope => 'web', :description => 'search from baidu, get web page')
    Engine.create(:name => 'qihoo_wenda', :nickname => '奇虎问答', :url => 'http://www.qihoo.com/', :scope => 'wenda', :description => 'search from qihoo, get wenda page')
  end
end
