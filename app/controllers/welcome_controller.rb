class WelcomeController < ApplicationController
  before_filter :login_required

  def index
     
  end

  def joined_groups
    @expenses = Expense.find(:all, :conditions => ["group_id IN (?)", @current_user.groups.map { |g| g.id}], :order => "id DESC", :limit => 20)
    render :template => 'welcome/expenses.html', :layout => false
  end

  def managed
    groups = @current_user.groups.managed_groups
    @expenses = Expense.find(:all, :conditions => ["group_id IN (?)", groups.map { |g| g.id}], :order => "id DESC", :limit => 20)

    render :template => 'welcome/expenses.html', :layout => false
  end

  def my
    @expenses = @current_user.expenses.find(:all, :order => "id DESC")
    @expenses.delete_if { |e| !e.group }

    render :template => 'welcome/expenses.html', :layout => false
  end

end
