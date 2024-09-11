class BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization
  before_action :set_board, only: [ :show, :edit, :update, :destroy ]

  def index
    @boards = @organization.boards
  end

  def show
    @lists = @board.lists.includes(:cards)
  end

  def new
    @board = @organization.boards.build
  end

  def create
    @board = @organization.boards.build(board_params)
    if @board.save
      redirect_to organization_board_path(@organization, @board), notice: "Board was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to organization_board_path(@organization, @board), notice: "Board was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @board.destroy
    redirect_to organization_boards_path(@organization), notice: "Board was successfully destroyed."
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def board_params
    params.require(:board).permit(:name, :description, :visibility)
  end
end
