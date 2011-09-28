# encoding: utf-8
$:.unshift(File.dirname(__FILE__))
require 'forager_base'

module Forager
  class ForageBaiduWeb < ForagerBase

    def get_result(key_word)
      ic = Iconv.new('UTF-8//IGNORE', 'gb2312')
      #open page
      page = get_page(FORAGE_SOURCE[:baidu_web])
      print_and_exit('load page error, please check your giving url.') if page.nil?
      # File.new(get_path("form.html"), "w").write(page.body)
      
      #submit form
      sform = page.form_with(:action => "/s")
      sform.wd = key_word
      spage = sform.submit
      # doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))      
      doc = Hpricot(ic.iconv(spage.body))

      results = doc.at("div[@id='container']")
      return '' if results.nil?
      index = 0
      list_arr = []
      
      #if has result-op
      
      
      #else
      results.search("table[@class='result']").each do |res|
        item_hash = {:title => '', :url => '', :desc => ''}
        title = res.at("h3").inner_text
        if title =~ /(News|Books|Images|Videos) for/i
           puts "next..."
           next
        end
        item_hash[:title] = title

        item_hash[:url] = res.at("h3").at("a").attributes['href'].to_s
        
        desc = res.at("font").inner_text
        if desc =~ /^(.*)(\.{3}|<span class="g"|<font color=)/
          desc = $1
        end
        item_hash[:desc] = desc
        
        list_arr << item_hash
        index += 1
      end

      puts "total: " + index.to_s
      return list_arr
    end
  end
end

# ForageBaiduWeb.new(ARGV).run if __FILE__ == $0