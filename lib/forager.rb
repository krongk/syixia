$:.unshift(File.dirname(__FILE__))
require 'baidu_web/lib/baidu_web'
require 'baidu_top/lib/baidu_top'
require 'qihoo_wenda/lib/qihoo_wenda'

module Forager

  def self.get_result(opts)
    case opts[:source]
    when :web
      return BaiduWeb.search(opts[:key_word], :per_page => 20, :page_index => opts[:page])
    when :wenda
    	return QihooWenda.search(opts[:key_word], :per_page => 10, :page_index => opts[:page])
    when :baidu_top
      return BaiduTop.search(opts[:cate])
    else
    	return nil
    end
  end
end