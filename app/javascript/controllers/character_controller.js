import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="character"
export default class extends Controller {
  static targets = [ "input" ]

  connect() {
    // console.log(this.inputTargets)
  }

  disabled() {
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
}
