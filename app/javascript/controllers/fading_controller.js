import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fading"
export default class extends Controller {
  connect() {
    console.log(this.element.children[1])
    if (window.location.pathname === "/universes") {
      console.log("coucou")
    this.element.children[0].classList.remove('overlay-transition-black')
    this.element.children[0].classList.add('overlay-transition')
    setTimeout(() => {
      this.element.children[0].classList.remove('overlay-transition')
    }, 1000);
  }

  }
  fade(event) {
    event.preventDefault()
    this.element.firstElementChild.classList.add('overlay-transition-black')
    this.element.firstElementChild.classList.remove('overlay-transition')
    setTimeout(() => {
      window.location.href = "/universes"
  }, 1500)
  }
}
