class WelcomeController < ApplicationController
  before_filter :login_required

  def index
    @expenses = Expense.find(:all, :conditions => ["group_id IN (?)", @current_user.groups.map { |g| g.id}], :order => "id DESC", :limit => 20) 
  end

  def managed
    groups = @current_user.groups.managed_groups
    @expenses = Expense.find(:all, :conditions => ["group_id IN (?)", groups.map { |g| g.id}], :order => "id DESC", :limit => 20)

    render :action => 'index'
  end

  def my
    @expenses = @current_user.expenses.find(:all, :order => "id DESC")
    render :action => 'index'
  end

end
