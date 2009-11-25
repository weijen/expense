class WelcomeController < ApplicationController
  before_filter :login_required

  def index
    @expenses = Expense.find(:all, :conditions => ["group_id IN (?)", @current_user.groups.map { |g| g.id}], :order => "id DESC", :limit => 20) 
  end

end
