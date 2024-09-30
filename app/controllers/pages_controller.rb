class PagesController < ApplicationController
  def home
    if user_signed_in?
      @user = current_user
      @organizations = @user.all_organizations
    end
  end
end
