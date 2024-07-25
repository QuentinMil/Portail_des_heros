import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carousel-universe"
export default class extends Controller {
  static values = { universe: String }
  connect() {
    if (this.element.classList.contains("active")) {
      this.element.classList.toggle("carousel-unset")

    }else{
      this.element.classList.toggle("carousel-unset")

    }
  }
}
