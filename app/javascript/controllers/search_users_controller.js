import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-users"
export default class extends Controller {
  static targets = ["form", "input"]

  connect() {
    console.log(this.formTarget)
  }
}
