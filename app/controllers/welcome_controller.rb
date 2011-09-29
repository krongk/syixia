load 'forager.rb'
class WelcomeController < ApplicationController

  def index
    unless params[:q]
      render 'form', :layout => false
    end
    ic = Iconv.new('UTF-8//IGNORE', 'gb2312')
    @coder = HTMLEntities.new
    q = params[:q]
    q = q.force_encoding("utf-8") unless q.nil?
    q = @coder.encode(params[:q])
    t = params[:t] || 'baidu_web'
    options = {:source => t.to_sym, :key_word => q}
    @result = Forager.get_result(options)
  end

  def form

  end

  def result
  end

  #关于我们
  def about
    layout 'static'
  end

  #版权声明
  def faq
  end

  #意见建议
  def contact
  end

  def top
  end

  def share
  end

end