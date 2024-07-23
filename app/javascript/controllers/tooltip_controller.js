import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tooltip"
export default class extends Controller {
  static targets = [ "tooltip" ]

  connect() {
    new bootstrap.Tooltip(this.element)


  }
}
