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
    @membership = @organization.memberships.build(membership_params)
    if @membership.save
      redirect_to organization_membership_path(@organization, @membership), notice: "Membership was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @membership.update(membership_params)
      redirect_to organization_membership_path(@organization, @membership), notice: "Membership was successfully updated."
    else
      render :edit
    end
  end

  def destroy
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
    params.require(:membership).permit(:user_id, :organization_id, :role)
  end
end
