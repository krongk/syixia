# encoding: utf-8
ActiveAdmin.register Item do
  scope :"百度网页"
  scope :"奇虎问答"

  index do
  	column :id
    column "标题" do |item|
      link_to item.title, admin_item_path(item)
    end
    column "链接" do |item|
    	link_to truncate(item.url), item.url
    end
    column :updated_at
    default_actions
  end
end
