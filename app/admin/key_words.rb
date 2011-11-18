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
		  	key.items.sort do |item1, item2|
                iv1 = item1.item_value
                iv1_count = (iv1.engine_value.to_i + iv1.click_value.to_i + iv1.recommend_value.to_i + iv1.user_value.to_i + iv1.manual_value.to_i) if item1.item_value
                iv2 = item2.item_value
                iv2_count = (iv2.engine_value.to_i + iv2.click_value.to_i + iv2.recommend_value.to_i + iv2.user_value.to_i + iv2.manual_value.to_i) if item2.item_value
                iv2_count  <=>  iv1_count
            end.each do |item|
		  	  tr do 
		  	  	td do
		  	      "#{item.id} "
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