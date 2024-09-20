class CardsController < ApplicationController
  before_action :set_list, except: [ :update_position ]
  before_action :set_card, only: [ :show, :edit, :update, :destroy, :update_position ]

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

  def update_position
    @card.update(list_id: params[:card][:list_id])
    @card.insert_at(params[:card][:position].to_i)
    head :ok
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:title, :description, :due_date, :position, :assigned_user_id, :list_id)
  end
end
