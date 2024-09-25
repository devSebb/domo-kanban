class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :set_organizations, if: :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_organizations
    @organizations = current_user.organizations.includes(boards: :lists).distinct
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :username ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name, :username, :photo ])
  end
end
