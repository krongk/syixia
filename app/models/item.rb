class Item < ActiveRecord::Base
  belongs_to :key_word
  belongs_to :cate
end
