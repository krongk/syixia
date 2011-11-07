# encoding: utf-8
ActiveAdmin.register ItemValue do
  # filter :author, :as => :select, :collection => lambda{ Product.authors }
  filter :nil

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
