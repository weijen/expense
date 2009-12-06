class GroupsController < ApplicationController
  before_filter :login_required
  before_filter :get_group, :only=>[:edit, :update, :destroy, :show]
  before_filter :group_manager_required, :only=>[:edit, :update, :destroy]


  def index
    @groups = Group.all

    respond_to do |format|
      format.html 
    end
  end

  def show
    @start_date = Date.parse(params[:start_date]) || @group.created_at.to_date
    @end_date = Date.parse(params[:end_date]) || Date.today
    @users_report = @group.users_report(@start_date, @end_date)
    @tags_report = @group.tags_report(@start_date, @end_date)
    @report_total = 0.0
    @users_report.each { |item| @report_total += item[1] }
    respond_to do |format|
      format.html 
    end
  end

  def new
    @group = Group.new
    store_location

    respond_to do |format|
      format.html
    end
  end

  def edit
    store_location
  end

  def create
    @group = Group.new(params[:group])
    
    respond_to do |format|
      if @group.save
        @group.add_manager(@current_user)
        notice_stickie t("group.create_successfully")
        format.html { redirect_to(@group) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update

    respond_to do |format|
      if @group.update_attributes(params[:group])
        notice_stickie t("group.update_successfully")
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

  private

  def get_group
    @group = Group.find_by_secret_id(params[:id])
  end
  
end
