class ApplicationController < ActionController::Base
  before_action :set_categories
  before_action :set_preferences

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_active_admin_user!
    authenticate_admin_user!
    unless current_admin_user.admin?
      flash[:alert] = "Unauthorized Access!"
      redirect_to "/admin/logout"
    end
  end

  add_flash_types :info, :error, :success

  rescue_from ActionController::Redirecting::UnsafeRedirectError do
    redirect_to root
  end

  private
  def set_categories
    @categories = Category.all.sort_by &:title
  end

  def set_preferences
    @pref = Preference.all
  end
end
