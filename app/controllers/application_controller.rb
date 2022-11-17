class ApplicationController < ActionController::Base
  before_action :set_categories
  before_action :set_preferences

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_flash_types :info, :error, :success

  rescue_from ActionController::Redirecting::UnsafeRedirectError do
    redirect_to root
  end

  private
  def set_categories
    @categories = Category.all
  end

  def set_preferences
    @pref = Preference.all
  end
end
