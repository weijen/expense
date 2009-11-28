class GroupUsersController < ApplicationController
  before_filter :login_required
  before_filter :get_group_from_group_id
  before_filter :group_manager_required

  def index
    @group_users = @group.users
  end

  def approve
    user = User.find(params[:id])
    @group.add_approved_user(user)

    notice_stickie t("group_users.approve_user", :login => user.login)
    redirect_to group_users_path(@group)
  end

  def destroy 
    user = User.find(params[:id])
    @group.remove_joined_user(user)

    notice_stickie t("group_users.remove_user", :login => user.login)
    redirect_to group_users_path(@group)
  end

  private

end
