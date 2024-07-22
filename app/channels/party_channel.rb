# app/channels/party_channel.rb
class PartyChannel < ApplicationCable::Channel
  def subscribed
    party = Party.find(params[:id])
    stream_for party
  end

  def unsubscribed
    stop_all_streams
  end
end
