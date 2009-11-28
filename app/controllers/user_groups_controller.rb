class UserGroupsController < ApplicationController
  before_filter :login_required
  before_filter :get_group
  def join 
    @group.add_unapprove_user(@current_user)
    notice_stickie t('user_groups.join_stickie', :group => @group.name)
    redirect_to group_path(@group)
  end

  def destroy 
    @group.remove_joined_user(@current_user)
    notice_stickie t('user_groups.unjoint_stickie', :group => @group.name)
    redirect_to group_path(@group)
  end

  private
  
  def get_group
    @group = Group.find_by_secret_id(params[:id])
  end
end
