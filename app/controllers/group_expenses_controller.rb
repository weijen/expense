class GroupExpensesController < ApplicationController
  before_filter :login_required
  before_filter :get_group
  before_filter :group_follower_required
  before_filter :get_expense_and_owner_required, :only => [:edit, :update, :destroy]

  def index
    @expenses = @group.expenses.paginate :page => params[:page], :order => 'updated_at DESC', :per_page => 20
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
        format.html { redirect_to(@expense) }
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
        format.html { redirect_to(@expense) }
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

  def get_expense
    @expense = @group.expenses.find(params[:id])
    unless @current_user.expenses.indlude?(@expense)
      error_stickie("You are no right to edit this expense")
      return false
    end
    true
  end

end
