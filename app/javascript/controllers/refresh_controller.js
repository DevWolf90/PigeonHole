import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="refresh"
export default class extends Controller {
  static targets = ["form", "input", "list"]
  connect() {
    console.log(this.formTarget)
    console.log(this.inputTarget)
  }

  update() {
    // const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    // fetch(url, {
    //   method: 'POST',
    //   headers: { "Accept": 'application/json' },
    // })
    // .then(response => response.text())
    //   .then((data) => {
    //     console.log(data)
    //     this.formTarget.outerHTML = data.form
    //     if (data.inserted_item) {
    //       this.listTarget.insertouterHTML('beforeend', data.inserted_item)
    //     }
    //   })
}
}
