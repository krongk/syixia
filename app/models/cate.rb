class Cate < ActiveRecord::Base
  has_many :key_words
  has_many :items
end
