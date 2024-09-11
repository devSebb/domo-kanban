class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_organizations


  private

  def set_organizations
    @organizations = Organization.where(id: current_user.owned_organizations.pluck(:id))
      .or(Organization.where(id: current_user.organizations.pluck(:id)))
      .distinct if user_signed_in?
  end
end
