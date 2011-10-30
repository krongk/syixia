ActiveAdmin.register TopItem do

  form do |f|
  	f.inputs "Key Word" do
  	  f.input :top_cate_id, :as => :select,   :collection => TopCate.find(:all)
  	  f.input :key_word
  	end
  	f.inputs "Value" do
  	  f.input :trend, :as => :radio, :collection => ['rise', 'down', 'fair'], :checked => 'checked'
  	  f.input :today_value
  	  f.input :seven_value
  	  f.input :manual_value
  	end
  	f.buttons
  end

  sidebar :help, :only => :index do
    "Need help? Email us at master@syixia.com"
  end

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