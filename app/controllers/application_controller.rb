# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  include AuthenticatedSystem
  before_filter :set_locale unless ["test", "cucumber"].include?(Rails.env)
  before_filter :prepare_for_mobile

  def group_manager_required
    unless @current_user.manager?(@group)
      error_stickie t(:have_no_right_to)
      redirect_to "/"
      return false
    end
    return true
  end

  def group_approved_user_required
    unless @current_user.approved?(@group)
      error_stickie t(:have_no_right_to)
      redirect_to "/"
      return false
    end
    return true
  end

  def no_right_to_access
    error_stickie t(:have_no_right_to)
    redirect_to "/"
    return false
  end

  def get_group_from_group_id
    @group = Group.find_by_secret_id(params[:group_id])
  end

  private
  
  def set_locale
    if params[:locale] && VALID_LOCALES.include?( params[:locale] )
      locale = params[:locale]
    end
    I18n.locale = locale || (current_user ? current_user.locale : nil) || I18n.locale
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale } unless ["test", "cucumber"].include?(Rails.env)
  end

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == '1'
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end

  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end

end
