import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tooltip"
export default class extends Controller {
  static targets = [ "tooltip" ]

  connect() {
    this.tooltipTargets.map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

  }
}
