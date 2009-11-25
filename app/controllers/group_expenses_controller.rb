class GroupExpensesController < ApplicationController
  before_filter :login_required
  before_filter :get_group
  before_filter :group_follower_required
  before_filter :get_expense_and_owner_required, :only => [:edit, :update, :destroy]

  def index
    @expenses = @group.expenses.find(:all, :order => :charge_date)
    @total = @group.expenses.total
  end

  def new
    @expense = @group.expenses.new
  end

  def create
    @expense = @group.expenses.new(params[:expense])
    @expense.user = @current_user

    respond_to do |format|
      if @expense.save
        notice_stickie("Expense was successfully created.")
        format.html { redirect_to group_expenses_url(@group) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        notice_stickie('Expense was successfully updated.')
        format.html { redirect_to group_expenses_url(@group) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to(expenses_url) }
    end
  end

  private
  def get_group
    @group = Group.find_by_secret_id(params[:group_id])
  end

  def get_expense_and_owner_required
    @expense = @group.expenses.find(params[:id])
    unless @current_user.expenses.include?(@expense)
      error_stickie("You are no right to edit this expense")
      return false
    end
    true
  end

end
