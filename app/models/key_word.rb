class KeyWord < ActiveRecord::Base
  belongs_to :engine
  belongs_to :cate

  def self.recent(count)
  	KeyWord.order("updated_at DESC").limit(count)
  end
end
