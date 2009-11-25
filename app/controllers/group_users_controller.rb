class GroupUsersController < ApplicationController
  before_filter :login_required
  before_filter :get_group
  before_filter :group_owner_required

  def index
    @followers = @group.users
  end

  def prove
    user = User.find(params[:id])
    @group.add_follower(user)

    notice_stickie "Prove user: #{user.login}"
    redirect_to group_users_path(@group)
  end

  def destroy 
    user = User.find(params[:id])
    @group.remove_follower(user)

    notice_stickie "Remove user: #{user.login}"
    redirect_to group_users_path(@group)
  end

  private

  def get_group
    @group = Group.find_by_secret_id(params[:group_id])
  end
end
