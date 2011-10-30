class Contact < ActiveRecord::Base

  def self.recent(count)
  	Contact.order('created_at DESC').limit(count)
  end
end
