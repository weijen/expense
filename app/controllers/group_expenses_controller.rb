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
    if @group.frozen?
      error_stickie(t("group.frozen_message"))
      redirect_to group_path(@group)
    end

    if @group.froze_before_date
      notice_stickie(t("group.frozen_before_date", :frozen_date => @group.froze_before_date))
    end
    @expense = @group.expenses.new(:entry_date => Date.today)
    store_location

    respond_to do |format|
      format.html
      format.mobile
    end
  end

  def create
    if @group.frozen?
      error_stickie(t("group.frozen_message"))
      redirect_to group_path(@group)
    end

    @expense = @group.expenses.new(params[:expense])
    @expense.user = @current_user

    respond_to do |format|
      if @expense.save
        notice_stickie(t(:create_successfully_stickie, :name => Expense.human_name))
        format.html { redirect_to group_expenses_url(@group) }
        format.mobile {redirect_to group_expenses_url(@group)}
      else
        format.html { render :action => "new" }
        format.mobile { render :action => "new" }
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
    @tags = @group.tags.outgoing 
    @kind = "outgoing"
  end

end
