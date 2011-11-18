class ItemsController < InheritedResources::Base
  #before_filter :authenticate_admin_user!
  # before_filter :load_key_word

  # def load_key_word
  # 	@key_word = KeyWord.find(params[:key_word_id])
  # end

  # def index
  # 	@items = @key_word.items
  # end
end
