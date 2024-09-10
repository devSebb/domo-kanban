class MembershipsController < ApplicationController
  before_action :set_membership, only: [ :show, :edit, :update, :destroy ]
  before_action :set_organization, only: [ :index, :new, :create ]
  def index
  end

  def show
  end

  def new
    @membership = @organization.memberships.build
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @membership = @organization.memberships.build(membership_params)

    if @membership.save
      redirect_to @organization, notice: "User invited successfully."
    else
      redirect_to @organization, alert: "Failed to invite user."
    end
  end

  def edit
    @organization = @membership.organization
  end

  def update
    @organization = @membership.organization
    if @membership.update(membership_params)
      redirect_to organization_membership_path(@organization, @membership), notice: "Membership was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @organization = @membership.organization
    @membership.destroy
    redirect_to organization_memberships_path(@organization), notice: "Membership was successfully destroyed."
  end

  private

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :role)
  end
end
