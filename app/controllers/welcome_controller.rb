# encoding: utf-8
load 'forager.rb'
class WelcomeController < ApplicationController

  def index
    unless params[:q]
      render 'form', :layout => false
    end
    @ic = Iconv.new('UTF-8//IGNORE', 'gb2312//IGNORE')
    @ic2 = Iconv.new('gb2312//IGNORE', 'UTF-8//IGNORE')
    @coder = HTMLEntities.new

    #get key word
    q = params[:q]
    q = q.squeeze(' ').strip unless q.blank?

    #get search source <web, wenda>
    t = params[:t] || 'web'
    t = ['web', 'wenda'].include?(t) ? t : 'web'

    #get page number
    @page = params[:page].to_i || 1
    @page = (1..100).include?(@page) ? @page : 1

    options = {:source => t.to_sym, :key_word => CGI.escape(@ic2.iconv(q)), :page => @page}
    @result = Forager.get_result(options)

    #store in database
    store_and_update(q, @result)
  end

  def form

  end

  def result
  end

  #关于我们
  def about
    
  end

  #版权声明
  def faq
  end

  #意见建议
  def contact
    redirect_to new_contact_path
  end

  # logic:
  # 1. everyday, fetch once to store in database
  # 2. if new, create !done
  # 3. if exist, update current.today_value = (old.today_value + new.today_value)/2
  # 4. re-count avg_value
  # 5. sort by avg_value and display on view
  # result = {:record_arr => [record], :source => 'baidu_top', :cate => 'book'}
  def top
    options = {:source => :baidu_top, :cate => :book}
    @result = Forager.get_result(options)

    #store in database
    top_cates = TopCate.where(:engine => 'baidu', :cate_name => 'book')
    unless top_cates.empty?
      top_cate = top_cates.first 
      unless top_cate.top_items.size > 0
        @result[:record_arr].each_with_index do |r, i|
          top_cate.top_items.create!(
            :key_word => r.key_word,
            :item_index => i+1,
            :trend => r.trend,
            :today_value => r.today_count,
            :seven_value => r.total_count
          )
        end
      end
    end
  end

  def job
  end

  private
  # logic:
  # 1. if key word is new, store key word, store 20 items, store item values
  # 2. if key word exist, ...
  # 3. don't care and store extension key words.
  # result = {:record_arr => [], :ext_key_arr => [], :source => 'web'}
  # result = {:record_arr => [], :ext_key_arr => [], :source => 'wenda'}
  # attr_accessor :title, :url, :summary, :date, :item_index, :size, :cached_url
  def store_and_update(key_word, result)
    begin
      # store baidu web
      if @result[:source] == 'web'
        # User.find_or_create_by_name('Bob', :age => 40) { |u| u.admin = true }
        engine = Engine.find_or_create_by_name('baidu_web')
        key_word = engine.key_words.find_or_create_by_name(key_word)
        @result[:record_arr].each do |r|
          next if key_word.items.where(:url => r.url)
          item = key_word.items.create(
            :title => r.title,
            :url => r.url,
            :updated_date => r.date,
            :summary => r.summary,
            :cached_url => r.cached_url,
            :item_index => r.item_index
          )
          if item.present?
            item.item_value.create(
              :engine_value => 100
            )
          end
        end
      elsif @result[:source] == 'wenda'
        engine = Engine.find_or_create_by_name('qihoo_wenda')
        key_word = engine.key_words.find_or_create_by_name(key_word)
        @result[:record_arr].each do |r|
          next if key_word.items.where(:url => r.url)
          item = key_word.items.create(
            :title => r.title,
            :url => r.url,
            :updated_date => r.date,
            :summary => r.summary,
            :cached_url => r.cached_url,
            :item_index => r.item_index
          )
          if item.present?
            item.item_value.create(
              :engine_value => 10
            )
          end
        end
      end
    rescue => ex
      puts "========"
      puts ex.message

    end
  end
end