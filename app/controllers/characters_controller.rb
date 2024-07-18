class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @character = Character.new
  end

  def edit
    set_character
  end

  def update
    set_character
    if @character.update(character_params)
      @character.update_completion_rate
      redirect_to @character, notice: 'Character was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_character
    @character = Character.find(params[:id])
  end

  def character_params
    params.require(:character).permit(:name, :universe_id, :race_id, :univers_class_id, :strength, :dexterity, :intelligence, :constitution, :wisdom, :charisma, :available_status)
  end
end
