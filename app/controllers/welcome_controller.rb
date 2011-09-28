load 'forager.rb'
class WelcomeController < ApplicationController

  def index
    unless params[:q]
      render 'form', :layout => false
    end
    @coder = HTMLEntities.new
    q = @coder.encode(params[:q])
    t = params[:t] || 'baidu_web'
    options = {:source => t.to_sym, :key_word => q}
    @result = Forager.get_result(options)
  end

  def form

  end

  def result
  end

  def about
  end

  def faq
  end

  def contact
  end

  def top
  end

  def share
  end

end
