class KeyWordsController < InheritedResources::Base
    before_filter :authenticate_admin_user!
end
