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

  def top
  end

  def share
  end

end