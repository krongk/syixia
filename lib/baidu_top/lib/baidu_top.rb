# encoding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'hpricot'
require 'open-uri'
require 'iconv'
require 'cgi'
require "baidu_top/version"
require "baidu_top/record"

module BaiduTop
  class << self
    def search(cate)
        result = {:record_arr => [], :source => 'baidu_top', :cate => 'book'}

        ic = Iconv.new("UTF-8//IGNORE", "GBK//IGNORE")

        url = nil
        case cate
        when :book
            url = "http://top.baidu.com/buzz.php?p=book"
        when :movie
            url = "http://top.baidu.com/buzz.php?p=movie"
        else
            url = "http://top.baidu.com/buzz.php?p=weekhotspot"
        end

        agent = Mechanize.new
        #      form_page = agent.get("http://www.baidu.com")
        #      sform = form_page.form_with(:action => "/s")
        # sform.wd = @key_word
        # spage = sform.submit
        # #debug:
        #
        spage = agent.get(url)
        #debug
        # File.open(File.join(File.dirname(__FILE__), 'baidu_result.html'), "w"){|f| f.write(@ic.iconv(spage.body))}

        doc = Hpricot(ic.iconv(spage.body))

        record_arr = []
        list = doc.at("div.list")
        list.search("//tr").each do |tr|
            record = Record.new
            td = tr.search("//td")
            record.key_word = td[0].inner_text
            record.trend = td[2].inner_html
            record.today_count = td[3].inner_text
            record.total_count = td[4].inner_text
            record_arr << record
        end
        puts record_arr
        puts record_arr.size
        result[:record_arr] = record_arr
        return result
    end
  end
end
