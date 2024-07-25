class CharactersController < ApplicationController
  before_action :authenticate_user! # Assure que l'utilisateur est connecté
  before_action :set_character, only: [:show, :edit, :update, :destroy, :image]

  def index
    @characters = current_user.characters
    if @characters.empty?
      redirect_to universes_path, notice: 'Vous devez créer un personnage avant de continuer.'
    end
  end

  def all_characters
    @characters = Character.order(updated_at: :desc)
  end

  def create
    @character = Character.new
    @character.user = current_user
    @character.universe_id = params[:universe_id] if params[:universe_id].present?
    @character.completion_rate = 1
    @character.save!

    if @character.save
      redirect_to edit_character_path(@character), notice: 'Le character a été créé !'
    else
      render :new
    end
  end

  def edit
    # l'action set_character est appelée par le before_action
    @tutorials = @character.universe.tutorials.order(:tuto_order)
  end

  def show
     # l'action set_character est appelée par le before_action
  end

  def update
    updated_fields = character_params.keys.count

    if @character.update(character_params)
      new_completion_rate = [@character.completion_rate + updated_fields, 10].min
      @character.update(completion_rate: new_completion_rate)

      if @character.completion_rate == 10
        @character.update(available_status: "Active")
        assign_to_party(@character)
        
        # Générer une backstory pour le personnage si le taux de complétion est complet
        # GenerateBackstoryJob.perform_later(@character.id)
        
        redirect_to @character, notice: 'Votre personnage est maintenant complet et prêt !'
      else
        redirect_to edit_character_path(@character), notice: 'Mise à jour du personnage effectuée. Continuez à remplir les informations.'
      end
    else
      render :edit
    end
  end


  def image
    # Extraire l'URL de l'image depuis les paramètres
  end

  def destroy
    # l'action set_character est appelée par le before_action
    @character.destroy
    redirect_to characters_path, notice: 'Character was successfully destroyed.'
  end

  def backstory_partial
    @character = Character.find(params[:id])
    render partial: 'backstory', locals: { character: @character }
  end

  private

  def set_character
    @character = Character.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to characters_path, alert: 'Character not found'
  end

  def character_params
    params.require(:character).permit(:name, :universe_id, :race_id, :univers_class_id, :strength, :dexterity, :intelligence, :constitution, :wisdom, :charisma, :available_status)
  end

  def assign_to_party(character)
    # Attribuer le personnage à la première partie trouvée
    first_party = Party.first
    PartyCharacter.create!(character: character, party: first_party, status: 'accepted') if first_party
  end
end
