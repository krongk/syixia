# encoding: utf-8
ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
    section "最近搜索关键词", :priority => 2 do
      ul do
        KeyWord.recent(10).collect do |k|
          li link_to(k.name, admin_key_word_path(k))
        end
      end
    end

    section "最近修改关键词", :priority => 1 do
      ul do
        res = KeyWord.joins("join items it on it.key_word_id = key_words.id join item_values itv on itv.item_id = it.id WHERE itv.manual_value <> 0 ORDER BY itv.updated_at DESC LIMIT 15")
        res.each do |r|
          li link_to(r.name, admin_key_word_path(r))
        end
      end
    end

    section "最新留言" do
      ul do
        Contact.recent(5).collect do |contact|
          li link_to(contact.title, admin_contact_path(contact))
        end
      end
    end
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
