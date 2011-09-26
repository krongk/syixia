# == Synopsis
#
# This is a base Class
# == Usage
#    class MechanizeTest < MechanizeExtractionBase
#
#    ruby mechanize_test.rb -u <url> -k <key_word>
#       -u  url, tell where to get the page. e.g. http://www.google.com/ncr
#       -k  key word, tell what key word to search

# command line argument parsing
require 'rubygems'
require 'optparse'
require 'rdoc'
require 'pp'

# mechanize lib
require 'logger'
require 'mechanize'
require 'hpricot'

# re-use Exception
class Exception
  attr_accessor :method_name
end

class ExtractException < Exception ; end

# define main class
class MechanizeExtractionBase
  def print_and_exit(msg)
      puts
      puts '*** ERROR ***'
      puts msg
      puts
      exit
  end
  
  def initialize(args)
    print_and_exit($USAGE) if args.length == 0
    
    opt = OptionParser.new
    opt.on('-h', '--help') { RDoc::usage}
    opt.on('-u', '--url url') { |url| @url = url }
    opt.on('-k', '--key_word key_word') { |key_word| @key_word = key_word }
    opt.on('-p', '--proxy proxy') { |proxy| @proxy = true }
    opt.parse!(args) rescue RDoc::usage
    print_and_exit('please provide the url with -u <url>') if @url.nil?

    init_mechanize
  end
  
  def init_mechanize
    @agent = Mechanize.new {|m| m.log = Logger.new("data_extraction_1.log")}
    # @agent.set_proxy('localhost', '8118') if @proxy
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
