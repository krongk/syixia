# encoding: utf-8
ActiveAdmin.register ItemValue do
  # filter :author, :as => :select, :collection => lambda{ Product.authors }
  filter :nil

  index do
    column :id
    column :"关键词" do |item_value|
      key_word = item_value.item.key_word
      link_to key_word.name, admin_key_word_path(key_word)
    end
    column :"项目名" do |item_value|
      item = item_value.item
      link_to item.title, admin_item_path(item)
    end
    column :engine_value
    column :click_value
    column :recommend_value
    column :user_value
    column :manual_value
    column :updated_at
    default_actions
  end
  #https://github.com/gregbell/active_admin/blob/master/docs/5-forms.md
  form do |f|
    f.inputs :item do
      f.input :engine_value
      f.input :click_value, :label => "点击权值"
      f.input :recommend_value
      f.input :user_value
    end
    f.inputs "人为调控" do
      f.input :manual_value
    end
    f.buttons
  end

end
