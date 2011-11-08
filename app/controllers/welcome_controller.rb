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
    # result = {:record_arr => [], :ext_key_arr => [], :source => 'web'}
    if @page == 1 && (key_word = KeyWord.find_by_name(q))
      puts "get database result"
      @result = {:record_arr => get_sorted_items(key_word).reverse, :ext_key_arr => [], :source => 'web'}
    else
      @result = Forager.get_result(options)
    end

    #store in database
    create_or_update(q, @result)
  end

  #when click item, active go action, update click_value and redirect
  def go
    item = Item.find_by_url(params[:url])
    if item
      item_value = item.item_value ? item.item_value : item.item_value.create!
      item_value.click_value += 1
      item_value.save!
    else
      #do nothing
    end
    redirect_to params[:url]
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
  #item sorted by sum value
  def get_sorted_items(key_word)
    key_word.items.sort do |item1, item2| 
      iv1 = item1.item_value
      iv1_count = iv1.engine_value.to_i + iv1.click_value.to_i + iv1.recommend_value.to_i + iv1.user_value.to_i + iv1.manual_value.to_i
      iv2 = item2.item_value
      iv2_count = iv2.engine_value.to_i + iv2.click_value.to_i + iv2.recommend_value.to_i + iv2.user_value.to_i + iv2.manual_value.to_i
      iv1_count <=> iv2_count
    end
  end
  # logic:
  # 1. if key word is new, store key word, store 20 items, store item values
  # 2. if key word exist, ...
  # 3. don't care and store extension key words.
  # result = {:record_arr => [], :ext_key_arr => [], :source => 'web'}
  # result = {:record_arr => [], :ext_key_arr => [], :source => 'wenda'}
  # attr_accessor :title, :url, :summary, :date, :item_index, :size, :cached_url
  def create_or_update(key_word, result)
    # begin
      # store baidu web
      if @result[:source] == 'web'
        # User.find_or_create_by_name('Bob', :age => 40) { |u| u.admin = true }
        engine = Engine.find_or_create_by_name('baidu_web')
        key_word = engine.key_words.find_or_create_by_name(key_word)
        
        unless key_word.items.all.size > 20
          exist_urls = key_word.items.all.map(&:url)
          @result[:record_arr].each_with_index do |r, index|
            next if exist_urls.include?(r.url)
            item = key_word.items.create!(
              :title => r.title,
              :url => r.url,
              :updated_date => r.updated_date,
              :summary => r.summary,
              :cached_url => r.cached_url,
              :item_index => r.item_index
            )
            if item.present?
              ItemValue.create!(:item_id => item.id, :engine_value => 100 - index)
            end
          end
        end
      elsif @result[:source] == 'wenda'
        engine = Engine.find_or_create_by_name('qihoo_wenda')
        key_word = engine.key_words.find_or_create_by_name(key_word)

        unless key_word.items.all.size > 20
          exist_urls = key_word.items.all.map(&:url)
          @result[:record_arr].each_with_index do |r, index|
            next if exist_urls.include?(r.url)
            item = key_word.items.create!(
              :title => r.title,
              :url => r.url,
              :updated_date => r.updated_date,
              :summary => r.summary,
              :cached_url => r.cached_url,
              :item_index => r.item_index
            )
            if item.present?
              #item.reload
              ItemValue.create!(:item_id => item.id, :engine_value => 90 - index)
            end
          end
        end
      end
    # rescue => ex
    #   puts "========"
    #   puts ex.message

    # end
  end
end