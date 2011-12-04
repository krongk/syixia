# encoding: utf-8
$:.unshift(File.dirname(__FILE__))

require "open-uri"
require "iconv"
require 'cgi'
require 'mechanize'
require "hpricot"
require "qihoo_wenda/version"
require "qihoo_wenda/record"
require "qihoo_wenda/extension_key"
require "qihoo_wenda/string_extension"
require "qihoo_wenda/strip"

module QihooWenda
  class << self
    def search(key_word, options)
    	result = {:record_arr => [], :ext_key_arr => [], :source => 'wenda'}

    	@ic = Iconv.new("UTF-8//IGNORE", "GB2312//IGNORE")

	  	@key_word = key_word
	  	return result if @key_word.blank?

	  	#determine how many records display on one page. (same as www.baidu.com/?rn=50)
	  	@per_page = options[:per_page]
	  	@per_page ||= 10

	  	#get which page of result. (same as www.baidu.com/?pn=0)
	  	@page_index = options[:page_index]
	  	@page_index ||= 1

	  	#get the start item index.
	  	item_index = (@page_index - 1 ) * @per_page
	  	#- this are hack on linux:
	  	agent = Mechanize.new
	  	agent.user_agent_alias = 'Mac Safari'
	  	
	  	url = "http://www.qihoo.com/wenda.php?do=search&src=jc&pos=1&kw=#{@key_word}&page=#{@page_index}"
	  	# url = "http://www.qihoo.com/wenda.php?do=search&src=jc&pos=1&kw=%CE%C4%BB%AF&page=1"
	  	#bugfix: URI::InvalidURIError (bad URI(is not URI?): ):
	  	# puts url
	  	# url = URI.parse(URI.encode(url))
	  	puts url
	  	
	  	#note: use open-uri will course encoding error, so you must get page use mechanize
	  	# open(uri, "r:gb2312:utf-8") {|f|
  		#   f.each_line do |line|
  		#   	 result_page += @ic.iconv(line)
  		#   end
	  	# }
	  	#fixbug: Encoding::UndefinedConversionError: "\xE9" from GBK to UTF-8
	  	# result_page = open(uri, "r:gb2312:utf-8")
	  	
	  	spage = agent.get(url)
	  	doc = Hpricot(@ic.iconv(spage.body))
	  	return result if doc.blank?

		result[:record_arr] = extract_item(doc, item_index)
		result[:ext_key_arr] = extract_extension_key(doc)
		#debug
		puts result[:record_arr].size

		return result
	  end
  
	  private
	  def extract_item(content, item_index)
	  	record_arr = []
	  	content = content.at("div[@id='clk_result_list']")
		return [] if content.nil?

		content.search("table[@class='results']").each do |res|
			record = Record.new

			title = res.at("font[@id^='title']").inner_text
			record.title = title
			record.url = res.at("td[@class='f']").at("a").attributes['href'].to_s

			summary = []
			res.search("font[@size='-1']").each do |font|
			  if font.attributes['color'] == "#9C9C9C"
			  	if font.inner_html =~ /^\s*(\d{4}-\d{1,2}-\d{1,2})\s*$/
			  		record.updated_date = $1
			  	end
			  elsif font.inner_text =~ /(.*)..\n\t\t/
			  	summary << $1
			  end
			end
			record.summary = summary.join("\n<br/>\n")

			item_index += 1
			record.item_index = item_index
			record_arr << record
		end
		#debug
		#pp record_arr
		return record_arr
	  end

	  def extract_extension_key(doc)
	  	rs = doc.at("//div.mSearch")
	  	return [] if rs.nil?
	  	ext_key_arr = []
	  	rs.get_elements_by_tag_name("a").each do |link|
	  	   ext_key = ExtensionKey.new
	  	   ext_key.title = link.inner_text
	  	   ext_key.parent_key = @key_word
	  	   ext_key.source = 'wenda'
	  	   ext_key_arr << ext_key
	  	end
	  	ext_key_arr
	  end

  end
end
