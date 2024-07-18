class TutorialsController < ApplicationController

  def index
    @universes = Universe.all
  end
end
