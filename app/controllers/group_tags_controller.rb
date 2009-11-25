class GroupTagsController < ApplicationController
  before_filter :login_required
  before_filter :get_group
  before_filter :group_follower_required
  before_filter :get_tag_and_owner_required, :only => [:edit, :update, :destroy]

  def index
    @tags = @group.tags.find(:all, :order =>"used_count DESC")
  end

  def new
    @tag = @group.tags.new
  end

  def edit
  end

  def create
    @tag = @group.tags.new(params[:tag])
    @tag.user = @current_user

    respond_to do |format|
      if @tag.save
        notice_stickie("Tag was successfully created.")
        format.html { redirect_back_or_default(group_tags_url(@group)) }
      else
        format.html { render :action => "new" }
      end
    end

  end

  def update
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        notice_stickie('Tag was successfully updated.')
        format.html { redirect_to group_tags_url(@group) }
      else
        format.html { render :action => "edit" }
      end
    end

  end

  def destroy
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to(group_tags_url(@group)) }
    end
  end

  private

  def get_group
    @group = Group.find_by_secret_id(params[:group_id])
  end

  def get_tag_and_owner_required
    @tag = @group.tags.find(params[:id])
    unless @current_user.tags.include?(@tag)
      error_stickie("You are no right to edit this tag")
      return false
    end
    true
  end

end
