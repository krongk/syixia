$:.unshift(File.dirname(__FILE__))
require 'forager/forage_baidu_web'

module Forager

  FORAGE_SOURCE = {
	:baidu_web => 'http://www.baidu.com/', 
	:qihoo_qa => 'http://www.qihoo.com/', 
	:google_web => 'http://www.google.com',
  }unless const_defined?(:FORAGE_SOURCE)

  def self.get_result(opts)
    case opts[:source]
    when :baidu_web
    	return Forager::ForageBaiduWeb.new(opts).get_result(opts[:key_word])
    when :qihoo_qa
    	return Forager::ForageQihooQa.get_result(opts[:key_word])
    else
    	return nil
    end
  end
end