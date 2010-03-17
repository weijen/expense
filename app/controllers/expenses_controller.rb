class ExpensesController < ApplicationController
  before_filter :login_required
  before_filter :get_expense_info, :only => [:new, :create, :edit, :update]
  before_filter :get_expense, :only => [:show, :edit, :update, :delete]

  def index
    @expenses = @current_user.expenses.find(:all, :order => "entry_date DESC")
    @groups = @current_user.groups.approved_groups
    @tags = @current_user.groups.approved_groups.first.tags.sort

    respond_to do |format|
      format.html 
    end
  end

  def show

    respond_to do |format|
      format.html
    end
  end

  def new
    @expense = @current_user.expenses.new

    respond_to do |format|
      format.html 
    end
  end

  def edit
    
  end

  def create
    @expense = @current_user.expenses.new(params[:expense])

    group = Group.find_by_secret_id(params[:group_id])
    @expense.group = group if group

    respond_to do |format|
      if @expense.save
        notice_stickie(t(:create_successfully_stickie, :name => Expense.human_name))
        format.html { redirect_to(@expense) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    group = Group.find_by_secret_id(params[:group_id])
    @expense.group = group if group && @expense.group != group

    params[:expense].each{ |key, value| @expense.send("#{key}=",value)}

    respond_to do |format|
      if @expense.save

        notice_stickie(t(:update_successfully_stickie, :name => Expense.human_name))
        format.html { redirect_to(@expense) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @expense = @current_user.expenses.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to(expenses_url) }
    end
  end

  private

  def get_expense_info
    @groups = @current_user.groups.approved_groups
    @tags = Tag.get_sorted_tags(@current_user, params[:kind])
    @kind = params[:kind] == "income" ? "income" : "outgoing"
  end

  def get_expense
    begin
      @expense = @current_user.expenses.find(params[:id])
    rescue
      no_right_to_access()
      return
    end
  end

end
