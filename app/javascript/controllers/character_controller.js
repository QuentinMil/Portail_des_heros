import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

// Connects to data-controller="character"
export default class extends Controller {
  static targets = [ "input", "click", "backstory", "photo" ]

  connect() {
    // Abonnement au canal ActionCable
    this.channel = consumer.subscriptions.create("CharacterChannel", {
      received: (data) => {
        if (data.character_id === parseInt(this.data.get("characterId"))) {
          this.updateCharacter(data)
        }
      }
    })
  }

  disabled(event) {
    console.log("coucou")
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
        const targetedOption = options.find(option => option.value === value)
        if (targetedOption) {
          targetedOption.disabled = "disabled"
        }
      })
    })
  }

  random(event) {
    const valeurs = [8, 10, 12, 13, 14, 15]
    const random = this.#shuffleArray(valeurs)
    this.inputTargets.forEach((input) => {
      input.value = random.pop()
    })
    event.target.disabled = true
  }

  #shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1))
      [array[i], array[j]] = [array[j], array[i]]
    }
    return array
  }

  updateCharacter(data) {
    alert(data.message)
    this.backstoryTarget.innerHTML = data.backstory
    this.photoTarget.src = data.photo_url
  }
}
