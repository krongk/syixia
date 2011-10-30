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

    Engine.create(:name => 'baidu_web', :nickname => 'baidu web search', :url => 'http://www.baidu.com', :scope => 'web', :description => 'search from baidu, get web page')
    Engine.create(:name => 'qihoo_wenda', :nickname => 'qihoo wenda', :url => 'http://www.qihoo.com/', :scope => 'wenda', :description => 'search from qihoo, get wenda page')
  end
end
