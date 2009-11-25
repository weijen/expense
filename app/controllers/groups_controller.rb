class GroupsController < ApplicationController
  before_filter :login_required
  before_filter :get_group, :only=>[:edit, :update, :destroy, :show]
  before_filter :group_owner_required, :only=>[:edit, :update, :destroy]


  def index
    @groups = Group.all

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
    @group = Group.new

    respond_to do |format|
      format.html
    end
  end

  def edit
  end

  def create
    @group = Group.new(params[:group])
    
    respond_to do |format|
      if @group.save
        @group.add_manager(@current_user)
        notice_stickie 'Group was successfully created.'
        format.html { redirect_to(@group) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update

    respond_to do |format|
      if @group.update_attributes(params[:group])
        notice_stickie 'Group was successfully updated.'
        format.html { redirect_to(@group) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
    end
  end

  def get_group
    @group = Group.find_by_secret_id(params[:id])
  end
  
end
