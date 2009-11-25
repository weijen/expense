class ExpensesController < ApplicationController
  before_filter :login_required

  def index
    @expenses = Expense.all

    respond_to do |format|
      format.html 
    end
  end

  def show
    @expense = Expense.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @expense = Expense.new
    @groups = @current_user.groups.proven
    respond_to do |format|
      format.html 
    end
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def create
    @expense = @current_user.expenses.new(params[:expense])

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
    @expense = Expense.find(params[:id])

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
    @expense = Expense.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to(expenses_url) }
    end
  end
end
