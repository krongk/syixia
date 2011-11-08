# encoding: utf-8
class Item < ActiveRecord::Base
  belongs_to :key_word
  belongs_to :cate
  has_one :item_value

  scope :"百度网页", joins("inner join key_words k on key_word_id = k.id join engines e on k.engine_id = e.id WHERE e.name = 'baidu_web'")
  scope :"奇虎问答", joins("inner join key_words k on key_word_id = k.id join engines e on k.engine_id = e.id WHERE e.name = 'qihoo_wenda'")
end
