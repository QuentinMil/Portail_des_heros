import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carousel-universe"
export default class extends Controller {
  static values = { universe: String }
  static targets = ["button"]
  connect() {
    if (this.element.classList.contains("active")) {
      this.element.classList.toggle("carousel-unset")
      this.buttonTarget.classList.add("universe-selector")
    }else{
      this.element.classList.toggle("carousel-unset")
      this.buttonTarget.classList.remove("universe-selector")
    }
  }
}
