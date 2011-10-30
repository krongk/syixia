# encoding: utf-8
ActiveAdmin.register Cate do
  
  sidebar :"提示", :only => :index do 
  	help_str = %{cate 即为了满足人工目录分类而设立
网站所有的目录，都以'syixia'为根目录
如：
|syixia
      |IT
      |财经
           |股票
           |基金}
    pre help_str
  end
end

