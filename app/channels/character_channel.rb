# app/channels/character_channel.rb
class CharacterChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user.id
    Rails.logger.info "CharacterChannel: User #{current_user.id} subscribed"
  end

  def unsubscribed
    stop_all_streams
    Rails.logger.info "CharacterChannel: User #{current_user.id} unsubscribed"
  end
end
