$:.unshift(File.dirname(__FILE__))
require 'mechanize_extraction_base'

class MechanizeExtractionBaiduWeb < MechanizeExtractionBase
  def run
    puts "....start...."
    puts @url
    
    #open page  
    page = get_page(@url)
    print_and_exit('load page error, please check your giving url.') if page.nil?
    File.new("form.html", "w").write(page.body)
    
    #submit form
    sform = page.form_with(:action => "/s")
    sform.wd = @key_word
    spage = sform.submit
    
    #extract search result page
    File.new("result.html", "w").write(spage.body)
    puts '...done...'
    
    doc = Hpricot(spage.body)
    results = doc.at("div[@id='container']")
    r_file = File.new("result_list.html", "w")
    index = 0
    item_hash = {:title => nil, :url => nil, :desc => nil}
    list_arr = []
    
    #if has result-op
    
    
    #else
    results.search("table[@class='result']").each do |res|
      item_hash = {:title => nil, :url => nil, :desc => nil}
      title = res.at("h3").inner_text.to_s
      if title =~ /(News|Books|Images|Videos) for/i
         puts "next..."
         next
      end
      item_hash[:title] = title
      puts "title: " + title
      puts "url:   " + item_hash[:url] = res.at("h3").at("a").attributes['href'].to_s
      
      desc = res.at("font").inner_html.to_s
      puts "desc: " + desc.sub(/<span.*<\/span>/, '').sub(/<a .*<\/a>/, '')
      if desc =~ /^(.*)(\.{3}|<span class="g"|<font color=)/
        desc = $1
      end
      item_hash[:desc] = desc
      
      list_arr << item_hash
      index += 1
    end
    
    r_file.write(list_arr.map{|r| "title: " + r[:title] + "\n <br>url: " + r[:url] + "\n <br>desc: " + r[:desc]}.join("\n<br><hr><br>\n"))
    r_file.close
    puts "total: " + index.to_s
  end
end

MechanizeExtractionBaiduWeb.new(ARGV).run if __FILE__ == $0