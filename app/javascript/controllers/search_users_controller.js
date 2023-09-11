import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";

// Connects to data-controller="search-users"
export default class extends Controller {
  static values = { options: Object }

  connect() {

    console.log(this.inputTarget)
    new TomSelect(this.element)
  }
}
