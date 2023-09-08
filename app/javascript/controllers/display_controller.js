import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["searchbar"]
  connect() {
  }

  show() {
    this.searchbarTarget.classList.toggle("d-none")
  }
}
