# encoding: utf-8
ActiveAdmin.register KeyWord do
  scope :"百度网页"
  scope :"奇虎问答"
  
  # https://github.com/gregbell/active_admin/blob/master/docs/6-show-screens.md
  show do |key|
  	attributes_table do
		row :name
		row :'结果' do 
		  table do
		  	key.items.sort{|x,y| x.item_index <=> y.item_index}.each do |item|
		  	  tr do 
		  	  	td do
		  	      "#{item.item_index} "
		  	    end
		  	    td do
		  	      link_to "#{item.title}", admin_item_path(item)
		  	    end
		  	    td do
		  	      iv1 = item.item_value
		  	      iv1_count = (iv1.engine_value.to_i + iv1.click_value.to_i + iv1.recommend_value.to_i + iv1.user_value.to_i + iv1.manual_value.to_i) if item.item_value
		  	      "#{iv1_count || 0}"
		  	    end
		  	    td do
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