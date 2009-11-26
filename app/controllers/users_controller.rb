class UsersController < ApplicationController
  before_filter :login_required, :only => [:edit, :update]

  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      notice_stickie(t(:signup_successfully_stickie))
    else
      error_stickie(t(:signup_fail_stickie))
      render :action => 'new'
    end
  end

  def edit
  end

  def update
  end
end
