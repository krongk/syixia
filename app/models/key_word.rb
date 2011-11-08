# encoding: utf-8
class KeyWord < ActiveRecord::Base
  belongs_to :engine
  belongs_to :cate
  has_many :items

  def self.recent(count)
  	KeyWord.order("updated_at DESC").limit(count)
  end

  scope :"百度网页", joins("inner join engines e on engine_id = e.id WHERE e.name = 'baidu_web'")
  scope :"奇虎问答", joins("inner join engines e on engine_id = e.id WHERE e.name = 'qihoo_wenda'")
end
