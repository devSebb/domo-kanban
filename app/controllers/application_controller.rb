class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_organizations
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_organizations
    @organizations = Organization.where(id: current_user.owned_organizations.pluck(:id))
      .or(Organization.where(id: current_user.organizations.pluck(:id)))
      .distinct if user_signed_in?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :username ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name, :username ])
  end
end
