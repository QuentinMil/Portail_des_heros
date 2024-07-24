# app/channels/character_channel.rb
class CharacterChannel < ApplicationCable::Channel
    def subscribed
      stream_for current_user
    end
  
    def unsubscribed
      stop_all_streams
    end
  end
  