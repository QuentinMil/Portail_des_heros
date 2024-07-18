class UniversesController < ApplicationController
  before_action :set_universe, only: [:show, :tutorials]

  def index
    @universes = Universe.all
  end

  def tutorials
    @tutorials = @universe.tutorials
  end

  def show
    @tutorial = @universe.tutorials.find_by(tuto_order: 1)
  end

  private

  def set_universe
    @universe = Universe.find(params[:id])
  end

end
