# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  include AuthenticatedSystem

  def group_owner_required
    unless @group.owners.include?(@current_user)
      error_stickie "You don't have the right to edit this group"
      redirect_to "/"
      return false
    end
    return true
  end

  def group_follower_required
    unless @group.followers.include?(@current_user)
      error_stickie "You don't have the right to edit this group"
      redirect_to "/"
      return false
    end
    return true

  end

end
