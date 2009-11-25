class GroupUsersController < ApplicationController
  before_filter :get_group
  def index
    @followers = @group.users
  end

  private

  def get_group
    @group = Group.find_by_secret_id(params[:group_id])
  end
end
