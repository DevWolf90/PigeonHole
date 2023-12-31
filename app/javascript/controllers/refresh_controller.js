import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="refresh"
export default class extends Controller {
  static targets = ["form", "input", "list", "checkbox"]
  connect() {
  }

  update() {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    fetch(url, {
      method: 'GET',
      headers: { "Accept": "text/plain" },
    })
    .then(response => response.text())
      .then((data) => {
        console.log(data)
        this.listTarget.outerHTML = data
      })
    }

  add(event) {
    console.log(event.target.checked)
    let url = `${document.location.href}?query=${this.inputTarget.value}`
    if (event.target.checked) {
      url = `${document.location.href}?query=${this.inputTarget.value}&q%5Btags_name_cont_any%5D%5B%5D=${event.target.value}`
    } else {
      const tagIndex = url.indexOf("&q%5Btags_name_cont_any%5D%5B%5D=")
      if (tagIndex !== -1) {
        const prefix = url.substring(0, tagIndex)
        let suffix = url.substring(tagIndex)
        const suffixEndIndex = suffix.indexOf("&")
        suffix = suffixEndIndex !== -1 ? suffix.substring(suffixEndIndex + 1) : ''
        url = `${prefix}${suffix}`
      }
    }
    fetch(url, {
      method: 'GET',
      headers: { "Accept": "text/plain" },
    })
    .then(response => response.text())
      .then((data) => {
        console.log(data)
        this.listTarget.outerHTML = data
      })
  }

  media(event) {
    console.log(event.target.checked)
    let url = `${document.location.href}?query=${this.inputTarget.value}`
    if (event.target.checked) {
      url = `${document.location.href}?query=${this.inputTarget.value}&q%5Btags_name_cont_any%5D%5B%5D=${event.target.value}&q%5Bmedia_type%5D%5B%5D=${event.target.value}`
    } else {
      const mediaIndex = url.indexOf("&q%5Bmedia_type%5D%5B%5D=")
      if (mediaIndex !== -1) {
        const prefix = url.substring(0, mediaIndex)
        let suffix = url.substring(mediaIndex)
        const suffixEndIndex = suffix.indexOf("&")
        suffix = suffixEndIndex !== -1 ? suffix.substring(suffixEndIndex + 1) : ''
        url = `${prefix}${suffix}`
      }
    }
    fetch(url, {
      method: 'GET',
      headers: { "Accept": "text/plain" },
    })
    .then(response => response.text())
      .then((data) => {
        console.log(data)
        this.listTarget.outerHTML = data
      })
  }
  }

  // http://localhost:3000/pigeons?query=&q%5Bmedia_type%5D%5B%5D=playlist
  // http://localhost:3000/pigeons?query=&q%5Btags_name_cont_any%5D%5B%5D=chill
