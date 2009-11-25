class GroupExpensesController < ApplicationController
  before_filter :login_required
  before_filter :get_group
  before_filter :group_follower_required

  def index
    @expenses = @group.expenses.paginate :page => params[:page], :order => 'updated_at DESC'
  end

  def new
  end

  def edit
  end

  def delete
  end

  private
  def get_group
    @group = Group.find_by_secret_id(params[:group_id])
  end

end
