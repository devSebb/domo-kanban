class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization, only: [ :show, :edit, :update, :destroy ]
  def index
    @organizations = Organization.where(id: current_user.owned_organizations.pluck(:id))
    .or(Organization.where(id: current_user.organizations.pluck(:id)))
    .distinct
  end

  def show
  end

  def new
    @organization = Organization.new
    @organization.memberships.build
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.owner = current_user


    if @organization.save
      redirect_to @organization, notice: "Organization was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @organization.update(organization_params)
      redirect_to organization_path(@organization), notice: "Organization was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @organization.destroy
    redirect_to organizations_path, notice: "Organization was successfully destroyed."
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name, :description, memberships_attributes: [ :user_id, :role ])
  end
end
