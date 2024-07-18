class UniversesController < ApplicationController
  def index
    @universes = Universe.all
  end

  def tutorials
    # parametarize pour changer id en nom d'univers dans l'url
    @universe = Universe.find(params[:id])
    @tutorials = @universe.tutorials
  end

  def show
    @universe = Universe.find(params[:id])
  end
end
