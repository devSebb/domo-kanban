class CardsController < ApplicationController
  before_action :set_card, only: [ :show, :edit, :update, :destroy ]
  before_action :set_list, only: [ :new, :create ]
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
      redirect_to organization_board_list_card_path(@list.organization, @list.board, @list, @card), notice: "Card was successfully created."
    else
      render :new
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
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def card_params
    params.require(:card).permit(:title, :description, :position, :due_date, :list_id, :assigned_user_id)
  end
end
