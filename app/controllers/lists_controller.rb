class ListsController < ApplicationController
  before_action :set_list, only: [ :show, :edit, :update, :destroy ]
  before_action :set_board, only: [ :index, :new, :create ]
  def index
    @lists = @board.lists
  end

  def show
  end

  def new
  end

  def create
    @list = @board.lists.build(list_params)
    if @list.save
      redirect_to board_list_path(@board, @list), notice: "List was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to board_list_path(@board, @list), notice: "List was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to board_lists_path(@board), notice: "List was successfully destroyed."
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def set_board
    @board = Board.find(params[:board_id])
  end

  def list_params
    params.require(:list).permit(:name, :position, :board_id)
  end
end
