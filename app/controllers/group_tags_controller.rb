class GroupTagsController < ApplicationController
  before_filter :login_required
  before_filter :get_group_from_group_id

  def index
    render :action =>'index', :layout => false
  end

end
