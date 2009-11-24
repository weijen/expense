class UserGroupsController < ApplicationController
  before_filter :login_required
  before_filter :get_group
  def follow 
    @current_user.groups << @group
    notice_stickie "Follow but not proven"
    redirect_to group_path(@group)
  end

  def unfollow
    @current_user.group.user_group_relations.destroy
    notice_stickie "Unfollowed this group"
    redirect_to group_path(@group)
  end

  private
  
  def get_group
    @group = Group.find_by_secret_id(params[:id])
  end
end
