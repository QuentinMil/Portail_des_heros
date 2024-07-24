import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

// Connects to data-controller="character"
export default class extends Controller {
  static targets = [ "input", "click" ]

  connect() {
    // console.log(this.inputTargets)
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
      const targetedOption = options.find(option => {
        return option.value === value
      })
      targetedOption.disabled = "disabled"
      })
    })
  }

  random(event) {
    // je construit un array avec mes valeurs [8, 10, 12, 13, 14, 15]
    const valeurs = [8, 10, 12, 13, 14, 15]
    // je shuffle mon array
    const random = this.#shuffleArray(valeurs)
    // j'itere sur mes inputs et je leur assigne une valeur
    this.inputTargets.forEach((input) => {
      input.value = random.pop()
    })
    event.target.disabled = true
  }

  #shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]]; // échange des éléments
    }
    return array;
  }
}
