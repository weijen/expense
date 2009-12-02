# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  include AuthenticatedSystem
  before_filter :set_locale

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
    { :locale => I18n.locale }
  end

end
