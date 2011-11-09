# encoding: utf-8
ActiveAdmin.register Item do
  scope :"百度网页"
  scope :"奇虎问答"

  filter :title

  index do
  	column :id
    column "关键词" do |item|
      link_to item.key_word.name, admin_key_word_path(item.key_word) if item.key_word
    end
    column "标题" do |item|
      link_to item.title, admin_item_path(item)
    end
    column "链接" do |item|
    	link_to truncate(item.url), item.url, :target => '_blank'
    end
    column "指数" do |item|
      link_to '指数', edit_admin_item_value_path(item.item_value) if item.item_value
    end
    column :updated_at
    default_actions
  end

  # form do |f|
    

  # end
end

  # form do |f|
  #     f.inputs "Details" do
  #       f.input :title
  #       f.input :published_at, :label => "Publish Post At"
  #       f.input :category
  #     end
  #     f.inputs "Content" do
  #       f.input :body
  #     end
  #     f.buttons
  #   end
  # f.input :author,  :as => :select,      :collection => { @justin.name => @justin.id, @kate.name => @kate.id }
  # f.input :author,  :as => :select,      :collection => ["Justin", "Kate", "Amelia", "Gus", "Meg"]
  # f.input :author,  :as => :radio,       :collection => User.find(:all)