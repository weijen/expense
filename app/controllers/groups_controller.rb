class GroupsController < ApplicationController
  before_filter :login_required
  before_filter :get_group, :except => [:index, :new, :create]
  before_filter :group_manager_required, :only=>[:edit, :update, :destroy, :freeze, :alive, :freeze_date]

  def index
    @groups = @current_user.groups 

    respond_to do |format|
      format.html 
    end
  end

  def show
    respond_to do |format|
      format.html do
        @start_date = Date.parse(params[:start_date]) rescue  (Date.today - 1.month)
        @end_date = Date.parse(params[:end_date]) rescue Date.today
      end
      format.mobile do
        @expenses = @group.expenses.find(:all, :limit => 5, :order => "id DESC", :conditions => ["user_id = ?", @current_user.id])
      end
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

  def freeze
    @group.set_freeze
    notice_stickie t('group.frozen_message')
    redirect_to(@group)
  end

  def alive
    @group.set_alive
    redirect_to(@group)
  end

  def freeze_date
    fd = Date.parse(params[:froze_before_date]) unless params[:froze_before_date].blank?
    @group.update_attribute(:froze_before_date, fd)
    redirect_to(@group)
  end

  def report
    @start_date = Date.parse(params[:start_date]) rescue Date.today - 1.month 
    @end_date = Date.parse(params[:end_date]) rescue Date.today

    respond_to do |format|
      format.mobile
    end
  end

  private

  def get_group
    @group = Group.find_by_secret_id(params[:id])
    unless @group
      no_right_to_access
      return false
    end
  end

end
