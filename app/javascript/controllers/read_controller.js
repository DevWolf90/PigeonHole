import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["button", "link"]
  static values = {
    id: Number
  }
  connect() {
    console.log("Hello");
  }

//   mark(event) {
//     event.preventDefault();
//     fetch(`/pigeons/${id}/toggle_read`, {
//       method: 'PATCH',
//       headers: { "Accept": 'application/json' }
//     })
//     .then(response => response.json())
//     .then(data => console.log(data))
// }
}
