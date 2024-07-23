import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["content"];

  connect() {
    console.log("Lexique controller connected");
  }

  load(event) {
    event.preventDefault();
    const url = event.currentTarget.getAttribute("href");

    fetch(url, {
      headers: {
        'Accept': 'text/vnd.turbo-stream.html'
      }
    })
    .then(response => response.json())
    .then(data => {
      this.contentTarget.innerHTML = `<h2>${data.title}</h2><p>${data.content}</p>`;
    });
  }
}
