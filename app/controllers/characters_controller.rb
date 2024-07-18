class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update]

  def index
    @characters = Character.all
  end

  def create
    @character = Character.new
    @character.user = current_user
    @character.universe_id = params[:universe_id] if params[:universe_id].present?
    @character.save!

    if @character.save
      @character.update_completion_rate
      redirect_to character_path(@character), notice: 'Tu viens de créer un nouveau Perso !'
    else
      render :new
    end
  end

  def edit
    # l'action set_character est appelée par le before_action
  end

  def show
     # l'action set_character est appelée par le before_action
  end

  def update
    # l'action set_character est appelée par le before_action
    if @character.update(character_params)
      new_completion_rate = @character.completion_rate + 1
      @character.update(completion_rate: new_completion_rate)
      if @character.completion_rate == 9
        redirect_to @character, notice: 'Le charater est terminé !'
      else
        redirect_to edit_character_path(@character)
      end
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
