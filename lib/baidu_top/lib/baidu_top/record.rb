module BaiduTop
  class Record
    attr_accessor :sort_id, :key_word, :trend, :today_value, :seven_value
  end
end

# Store the item of top result.
# 排名    关键词 趋势  今日搜索    最近七日    相关链接
# 
#　log:
# total_count __rename__> seven_value
# today_count __Rename__> today_value
# not use sort_id now