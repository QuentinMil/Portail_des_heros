class DashboardController < ApplicationController

  def index
    @user = current_user
    @parties = @user.parties
    @characters = @user.characters
    @messages = @user.messages
  end

end
