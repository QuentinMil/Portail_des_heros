import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

// Connects to data-controller="character"
export default class extends Controller {
  static targets = ["input", "click", "backstory", "photo"]

  connect() {
    // Debug message when the controller connects
    console.log("Character controller connected");

    // Abonnement au canal ActionCable
    console.log("Connecting to ActionCable channel: CharacterChannel");
    this.channel = consumer.subscriptions.create("CharacterChannel", {
      received: (data) => {
        console.log("Received data from ActionCable:", data);
        if (data.character_id === parseInt(this.data.get("characterId"))) {
          this.updateCharacter(data)
        }
      },
      connected: () => {
        console.log("Successfully connected to CharacterChannel");
      },
      disconnected: () => {
        console.log("Disconnected from CharacterChannel");
      }
    });

    console.log("Character controller fully set up.");
  }

  disabled(event) {
    console.log("Disabled event triggered");
    const inputValue = event.currentTarget.value
    const otherInputs = this.inputTargets.filter(input => input !== event.currentTarget)
    otherInputs.forEach(input => {
      const options = [...input.options]
      options.forEach(option => {
        option.disabled = false
      })
      const inputOtherInputs = this.inputTargets.filter(inputable => inputable !== input)
      const inputOtherInputsValues = inputOtherInputs.map(input => input.value)
      inputOtherInputsValues.forEach(value => {
        const targetedOption = options.find(option => {
          return option.value === value
        })
        targetedOption.disabled = "disabled"
      })
    })
  }

  random(event) {
    console.log("Random event triggered");
    // Je construis un array avec mes valeurs [8, 10, 12, 13, 14, 15]
    const valeurs = [8, 10, 12, 13, 14, 15]
    // Je shuffle mon array
    const random = this.#shuffleArray(valeurs)
    // J'itere sur mes inputs et je leur assigne une valeur
    this.inputTargets.forEach((input) => {
      input.value = random.pop()
    })
    event.target.disabled = true
  }

  #shuffleArray(array) {
    console.log("Shuffling array");
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]]; // Échange des éléments
    }
    return array;
  }

  updateCharacter(data) {
    console.log("Updating character with data:", data);
    alert(data.message)
    this.backstoryTarget.innerHTML = data.backstory
    this.photoTarget.src = data.photo_url
  }
}
