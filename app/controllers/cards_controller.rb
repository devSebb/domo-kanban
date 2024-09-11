class CardsController < ApplicationController
  before_action :set_list
  before_action :set_card, only: [ :show, :edit, :update, :destroy ]

  def index
    @cards = @list.cards
  end

  def show
  end

  def new
    @card = @list.cards.build
  end

  def create
    @card = @list.cards.build(card_params)
    if @card.save
      redirect_to organization_board_path(@list.board.organization, @list.board), notice: "Card was successfully created."
    else
      redirect_to organization_board_path(@list.board.organization, @list.board), alert: "Failed to create card."
    end
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to organization_board_list_card_path(@card.list.organization, @card.list.board, @card.list, @card), notice: "Card was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    if @card.destroy
      redirect_to organization_board_path(@list.board.organization, @list.board), notice: "Card was successfully deleted."
    else
      redirect_to organization_board_path(@list.board.organization, @list.board), alert: "Failed to delete card."
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_card
    @card = @list.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:title, :description, :position, :due_date, :assigned_user_id)
  end
end
