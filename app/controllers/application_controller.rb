# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  include AuthenticatedSystem

  def group_owner_required
    unless @current_user.manager?(@group)
      error_stickie t(:have_no_right_to)
      redirect_to "/"
      return false
    end
    return true
  end

  def group_follower_required
    unless @current_user.proven?(@group)
      error_stickie t(:have_no_right_to)
      redirect_to "/"
      return false
    end
    return true
  end

  before_filter :set_locale if @current_user
  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => @current_user ? @current_user.locale : I18n.locale }
  end

end
