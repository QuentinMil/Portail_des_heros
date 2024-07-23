// app/javascript/controllers/lexique_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content"];

  connect() {
    console.log("Lexique controller connected");
  }

  load(event) {
    event.preventDefault();
    const url = event.currentTarget.getAttribute("href");

    fetch(url)
      .then(response => response.json())
      .then(data => {
        this.contentTarget.innerHTML = `<h2>${data.title}</h2><p>${data.content}</p>`;
      })
      .catch(error => console.error("Error fetching the JSON:", error));
  }
}
