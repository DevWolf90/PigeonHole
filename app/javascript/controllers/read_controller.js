import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["read"]
  connect() {
    console.log("Hello");
  }

  mark() {

  }
}
