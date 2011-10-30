ActiveAdmin.register Contact do
  #
  filter :title

  index :as => :blog do
    title :title # Calls #my_title on each resource
    body  do |c|
    	div :class => 'content' do
    		h2 truncate(c.email)
    		span "Title: #{c.title}"
    		pre (c.content).html_safe
    	end
    end
  end

end

 # index :as => :blog do
 #    title :my_title
 #    body do |post|
 #      div truncate(post.title)
 #      div :class => 'meta' do
 #        span "Post in #{post.categories.join(', ')}"
 #      end
 #    end
 #  end

