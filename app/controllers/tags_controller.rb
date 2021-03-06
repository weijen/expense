class TagsController < ApplicationController
  before_filter :login_required

  def index
  end

  def new
    @group = Group.find_by_secret_id(params[:group_id]) if params[:group_id]
    @tag = Tag.new
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def create
    @group = Group.find_by_secret_id(params[:group_id]) if params[:group_id]
    @tag = Tag.new(params[:tag])
    @tag.user = @current_user

    respond_to do |format|
      if @tag.save
        @group.tags << @tag if @group
        notice_stickie(t(:create_successfully_stickie, :name => "#{Tag.human_name} : #{@tag.name}"))
        format.html { redirect_back_or_default(tags_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        notice_stickie(t(:update_successfully_stickie, :name => "#{Tag.human_name} : #{@tag.name}"))
        format.html { redirect_to tags_url(@group) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  private

end
