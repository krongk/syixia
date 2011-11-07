# encoding: utf-8
ActiveAdmin.register KeyWord do

  # https://github.com/gregbell/active_admin/blob/master/docs/6-show-screens.md
  show do |key|
  	attributes_table do
		row :name
		row :'结果' do 
		  ul do
		  	key.items.sort{|x,y| x.item_index <=> y.item_index}.each do |item|
		  	  ol do 
		  	  	span do
		  	      "#{item.item_index} - "
		  	    end
		  	    span do
		  	      link_to "#{item.title}", admin_item_path(item)
		  	    end
		  	    span do
		  	      link_to "(修改指数)", edit_admin_item_value_path(item.item_value)
		  	    end
		  	  end 
		    end
		  end
		end
  	end
  	active_admin_comments
  end
end

# https://github.com/gregbell/active_admin/blob/master/docs/6-show-screens.md
# show do |ad|
#     attributes_table do
#       row :title
#       row :image do
#         image_tag(ad.image.url)
#       end
#     end
#     active_admin_comments
#   end