class EnginesController < InheritedResources::Base
    before_filter :authenticate_admin_user!
end
