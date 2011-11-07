# encoding: utf-8
ActiveAdmin.register Item do
  scope :"百度网页"
  scope :"奇虎问答"

  # filter: 

  index do
  	column :id
    column "标题" do |item|
      link_to item.title, admin_item_path(item)
    end
    column "链接" do |item|
    	link_to truncate(item.url), item.url, :target => '_blank'
    end
    column "指数" do |item|
      link_to '指数', edit_admin_item_value_path(item.item_value)
    end
    column :updated_at
    default_actions
  end
end
