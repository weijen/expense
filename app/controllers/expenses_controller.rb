class ExpensesController < ApplicationController
  before_filter :login_required

  def index
    @expenses = @current_user.expenses.all

    respond_to do |format|
      format.html 
    end
  end

  def show
    @expense = @current_user.expenses.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @expense = @current_user.expenses.new
    @groups = @current_user.groups.delete_if{ |group| @current_user.unprove?(group) }
    respond_to do |format|
      format.html 
    end
  end

  def edit
    @groups = @current_user.groups.delete_if{ |group| @current_user.unprove?(group) }
    @expense = @current_user.expenses.find(params[:id])
  end

  def create
    @expense = @current_user.expenses.new(params[:expense])
    @groups = @current_user.groups.delete_if{ |group| @current_user.unprove?(group) }

    respond_to do |format|
      if @expense.save
        notice_stickie("Expense was successfully created.")
        format.html { redirect_to(@expense) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @expense = @current_user.expenses.find(params[:id])
    @groups = @current_user.groups.delete_if{ |group| @current_user.unprove?(group) }

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
    @expense = @current_user.expenses.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to(expenses_url) }
    end
  end
end
