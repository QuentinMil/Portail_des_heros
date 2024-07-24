# app/channels/application_cable/connection.rb
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email
    end

    def disconnect
      # Code pour gérer la déconnexion
      logger.add_tags 'ActionCable', "Disconnected user: #{current_user.email}"
      # Vous pouvez ajouter ici tout autre code nécessaire lors de la déconnexion
    end

    protected

    def find_verified_user
      if (current_user = env['warden'].user)
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
