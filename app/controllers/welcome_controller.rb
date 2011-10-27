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
      q = CGI.escape(@ic2.iconv(q))

      #get search source <web, wenda>
      t = params[:t] || 'web'
      t = ['web', 'wenda'].include?(t) ? t : 'web'

      #get page number
      @page = params[:page].to_i || 1
      @page = (1..100).include?(@page) ? @page : 1

      options = {:source => t.to_sym, :key_word => q, :page => @page}
      @result = Forager.get_result(options)
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

  # result = {:record_arr => [record], :source => 'baidu_top', :cate => 'book'}
  def top
    options = {:source => :baidu_top, :cate => :book}
    @result = Forager.get_result(options)


    top_cate = TopCate.find(1)
    unless top_cate.top_items.size > 0
      @result[:record_arr].each_with_index do |r, i|
        top_cate.top_items.create!(
          :key_word => r.key_word,
          :item_index => i,
          :trend => r.trend,
          :today_count => r.today_count,
          :total_count => r.total_count
        )
      end
    end
  end

  def job
  end

end
