class CardsController < ApplicationController
  before_action :set_project
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  layout 'dashboard'

  # GET /cards
  # GET /cards.json
  def index
    @cards = @project.cards
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = @project.cards.new(card_params)

    respond_to do |format|
      if @card.save
        @cards = @project.cards
        format.js
      else
        format.js { render json: @card.errors}
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        @cards = @project.cards
        format.js
      else
        format.js { render json: @card.errors }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      @cards = @project.cards
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = Card.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def card_params
    params.require(:card).permit(:title, :description)
  end
end
