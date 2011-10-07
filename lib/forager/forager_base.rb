# == Synopsis
#
# This is a base Class
# == Usage
#    class MechanizeTest < MechanizeExtractionBase
#
#    ruby forager_<source>.rb -s <source> -k <key_word>
#       -s  source, the search engine source from CONSTANT [baidu_web, google_web, qihoo_qa]
#       -k  key word, tell what key word to search

# command line argument parsing
require 'rubygems'
require 'optparse'
require 'pp'

# mechanize lib
require 'logger'
require 'mechanize'
require 'hpricot'

module Forager
  
  # re-use Exception
  class Exception
    attr_accessor :method_name
  end

  class Record
    attr_accessor :title, :url, :date, :summary, :item_index
  end
  class ExtractException < Exception ; end
  # define main class
  class ForagerBase
    def print_and_exit(msg)
        puts
        puts '*** ERROR ***'
        puts msg
        puts
    end
    
    def initialize(opts)
      puts '..........init.........'
      @source = opts[:srouce]
      @key_word = opts[:key_word]
      @proxy = false
      init_mechanize
    end
    
    def init_mechanize
      @agent = Mechanize.new {|m| m.log = Logger.new("forager_#{@source}.log")}
      @agent.set_proxy('localhost', '8118') if @proxy
      @agent.user_agent_alias = 'Linux Mozilla'
      @agent.open_timeout = 30
    end
    
    # get page
    def get_page(url)
      begin
        return @agent.get(url)
      rescue ExtractException => ex
        puts ex.message
        return nil
      end
    end
    
    def get_path(file_name)
      File.join(File.dirname(__FILE__), '..', '..', 'public', file_name)
    end

    def run
      puts "....start...."
      puts @url
      
      #open page  
      page = get_page(@url)
      print_and_exit('load page error, please check your giving url.') if page.nil?
      #submit form    
      #extract search result page
    end
  end
end