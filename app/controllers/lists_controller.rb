class ListsController < ApplicationController
  before_action :set_board
  before_action :set_list, only: [ :show, :edit, :update, :destroy ]

  def index
    @lists = @board.lists
  end

  def show
  end

  def new
    @list = @board.lists.build
  end

  def create
    @list = @board.lists.build(list_params)
    if @list.save
      redirect_to organization_board_path(@board.organization, @board), notice: "List was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to organization_board_path(@board.organization, @board), notice: "List was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to organization_board_path(@board.organization, @board), notice: "List was successfully destroyed."
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_list
    @list = @board.lists.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :position)
  end
end
