// app/javascript/controllers/navbar_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle", "navbar"]

  connect() {
    // console.log('Navbar controller connected');
    // console.log('Toggle target:', this.toggleTarget);
    // console.log('Navbar target:', this.navbarTarget);
    this.toggleTarget.addEventListener('click', this.toggleNavbar.bind(this));
    document.addEventListener('click', this.closeNavbar.bind(this));
  }

  disconnect() {
    // console.log('Navbar controller disconnected');  
    this.toggleTarget.removeEventListener('click', this.toggleNavbar.bind(this));
    document.removeEventListener('click', this.closeNavbar.bind(this));
  }

  toggleNavbar(event) {
    event.stopPropagation();
    // console.log('Toggling navbar');
    this.navbarTarget.classList.toggle('show');
    this.toggleTarget.classList.toggle('hidden');
  }

  closeNavbar(event) {
    if (!this.navbarTarget.contains(event.target) && !this.toggleTarget.contains(event.target)) {
      // console.log('Closing navbar');
      this.navbarTarget.classList.remove('show');
      this.toggleTarget.classList.remove('hidden');
    }
  }
}
