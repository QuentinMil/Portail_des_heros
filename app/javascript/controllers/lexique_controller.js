import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content", "form", "searchInput", "list"];

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
      });
  }

  update() {
    const url = `${this.formTarget.action}?query=${this.searchInputTarget.value}`;
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data;
      });
  }
}
