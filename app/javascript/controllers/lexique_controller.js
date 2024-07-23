import { Controller } from "@hotwired/stimulus";
import Awesomplete from "awesomplete";

export default class extends Controller {
  static targets = ["content", "form", "searchInput", "list"];

  connect() {
    console.log("Lexique controller connected");
    this.awesomplete = new Awesomplete(this.searchInputTarget, {
      minChars: 1,
      autoFirst: true,
      list: []
    });
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
    fetch(url, { headers: { 'Accept': 'application/json' } })
      .then(response => response.json())
      .then((data) => {
        this.awesomplete.list = data.map(post => post.title);
        const listHtml = data.map(post => `
          <li>
            <a href="${post_path(post, format: 'json')}" data-action="lexique#load">${post.title}</a>
          </li>
        `).join("");
        this.listTarget.innerHTML = listHtml;
      });
  }
}
