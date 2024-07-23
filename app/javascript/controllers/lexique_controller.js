import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content", "form", "searchInput", "list", "dictionary", "searchBar", "sections"];

  connect() {
    console.log("Lexique controller connected");
    this.sectionsTarget.addEventListener("scroll", this.handleScroll.bind(this));
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll.bind(this));
  }

  handleScroll() {
    const searchBar = this.searchBarTarget;
    const isSticky = searchBar.classList.contains("sticky");

    console.log("Scroll position:", this.sectionsTarget.scrollTop);
    console.log("Search bar sticky status:", isSticky);

    if (this.sectionsTarget.scrollTop > 0 && !isSticky) {
      console.log("Adding sticky class to search bar");
      searchBar.classList.add("sticky");
    } else if (this.sectionsTarget.scrollTop === 0 && isSticky) {
      console.log("Removing sticky class from search bar");
      searchBar.classList.remove("sticky");
    }
  }

  load(event) {
    event.preventDefault();
    const url = event.currentTarget.getAttribute("href");
    console.log(`Fetching content from URL: ${url}`);

    fetch(url)
      .then(response => response.json())
      .then(data => {
        console.log("Received data:", data);
        this.contentTarget.innerHTML = `<h2>${data.title}</h2><p>${data.content}</p>`;
      })
      .catch(error => {
        console.error("Error fetching content:", error);
      });
  }

  update() {
    const url = `${this.formTarget.action}?query=${this.searchInputTarget.value}`;
    console.log(`Updating list with URL: ${url}`);

    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then(data => {
        this.listTarget.innerHTML = data;
      })
      .catch(error => {
        console.error("Error updating list:", error);
      });
  }
}
