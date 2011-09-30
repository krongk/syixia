# encoding: utf-8
$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'mechanize'
require 'hpricot'
require 'open-uri'
require 'htmlentities'
require 'iconv'

#write to file
def write_to_file(file_name, content)
	file = File.new(file_name, "w:utf-8")
	file.write(%{<html><head><meta content="text/html;charset=utf-8" http-equiv="content-type"></head><body>})
	file.write(content)
	file.write(%{</body></html>})
	file.close
end

puts 'start...'
#test
key_word = "衣服"
puts key_word
key_word = CGI.escape(key_word)
puts key_word

page = open("http://www.baidu.com/s?wd=#{key_word}", "r:gb2312:utf-8")

# write_to_file("forage_baidu_web_before.html", page.readlines)

doc = Hpricot(page)

results = doc.at("div[@id='container']")
puts 'nil results' if results.nil?
index = 0
list_arr = []

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

	puts "total: " + index.to_s
end

write_to_file("forage_baidu_web_after.html", list_arr.join("<hr>"))

puts 'done...'