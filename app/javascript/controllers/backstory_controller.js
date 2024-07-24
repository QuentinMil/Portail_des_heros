// app/javascript/controllers/backstory_controller.js
import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

// Connects to data-controller="backstory"
export default class extends Controller {
  static targets = ["backstory", "photo"]
  static values = { characterId: Number }

  connect() {
    console.log("Backstory controller connected for character ID:", this.characterIdValue);

    if (!this.channel) {
      // Abonnement au canal ActionCable
      console.log("Connecting to ActionCable channel: CharacterChannel");
      this.channel = consumer.subscriptions.create(
        { channel: "CharacterChannel", character_id: this.characterIdValue }, {
        received: (data) => {
          console.log("Received data from ActionCable:", data);
          if (data.character_id === this.characterIdValue) {
            this.updateCharacter(data);
          }
        },
        connected: () => {
          console.log("Successfully connected to CharacterChannel for character ID:", this.characterIdValue);
        },
        disconnected: () => {
          console.log("Disconnected from CharacterChannel for character ID:", this.characterIdValue);
        }
      });

      console.log("Backstory controller fully set up for character ID:", this.characterIdValue);
    }
  }

  disconnect() {
    if (this.channel) {
      this.channel.unsubscribe();
      this.channel = null;
      console.log("Unsubscribed from CharacterChannel for character ID:", this.characterIdValue);
    }
  }

  updateCharacter(data) {
    // console.log("Updating character with data:", data);
    alert(data.message);

    // Met à jour la photo
    this.photoTarget.src = data.photo_url;

    // Récupère le contenu HTML de la partial backstory et remplace le contenu actuel
    fetch(`/mes_personnages/${data.character_id}/backstory_partial`)
      .then(response => response.text())
      .then(html => {
        this.backstoryTarget.outerHTML = html;
      })
      .catch(error => {
        console.error("Error fetching backstory partial:", error);
      });
  }
}
