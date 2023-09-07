import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-users"
export default class extends Controller {
  connect() {
    console.log("hello")
  }
}
