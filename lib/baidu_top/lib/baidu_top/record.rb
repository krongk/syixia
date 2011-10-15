module BaiduTop
  class Record
    attr_accessor :sort_id, :key_word, :trend, :today_count, :total_count
  end
end

# Store the item of top result.
# 排名    关键词 趋势  今日搜索    最近七日    相关链接
# 