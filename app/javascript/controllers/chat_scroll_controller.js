import { Controller} from "@hotwired/stimulus"


// Connects to data-controller="chat-scroll"



export default class extends Controller {
  static targets = ["scroll"]
  connect() {
    console.log("heo");
    this.scrollTarget.scrollIntoView()

  }
}
