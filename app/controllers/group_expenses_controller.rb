class GroupExpensesController < ApplicationController
  before_filter :login_required
  before_filter :get_group_from_group_id
  before_filter :group_approved_user_required
  before_filter :get_expense_and_owner_required, :only => [:edit, :update, :destroy]
  before_filter :get_expense_info, :only => [:new, :create, :edit, :update]

  def index
    @expenses = @group.expenses.find(:all, :order => "entry_date DESC")
    @total = @group.expenses.total
  end

  def new
    @expense = @group.expenses.new
    store_location
  end

  def create
    @expense = @group.expenses.new(params[:expense])
    @expense.user = @current_user

    respond_to do |format|
      if @expense.save
        notice_stickie(t(:create_successfully_stickie, :name => Expense.human_name))
        format.html { redirect_to group_expenses_url(@group) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    store_location
  end

  def update
    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        notice_stickie(t(:update_successfully_stickie, :name => Expense.human_name))
        format.html { redirect_to group_expenses_url(@group) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to(group_expenses_url(@group)) }
    end
  end

  private

  def get_expense_and_owner_required
    @expense = @group.expenses.find(params[:id])
    unless @current_user.expenses.include?(@expense)
      error_stickie(t(:have_no_right_to))
      return false
    end
    true
  end

  def get_expense_info
    @tags = Tag.get_sorted_tags(@current_user, params[:kind])
    @kind = params[:kind] == "income" ? "income" : "outgoing"
  end

end
