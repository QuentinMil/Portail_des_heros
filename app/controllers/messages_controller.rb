# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @party = Party.find(params[:party_id])
    @message = @party.messages.build(message_params)
    @message.user = current_user
    if @message.save
      # Diffuser le message via ActionCable
      PartyChannel.broadcast_to(
        @party,
        message: render_message(@message)
      )
      head :ok
    else
      redirect_to party_path(@party), alert: 'Votre message ne peut pas être vide.'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
