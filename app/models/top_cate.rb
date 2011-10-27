class TopCate < ActiveRecord::Base
	has_many :top_items, :dependent => :destroy
end
