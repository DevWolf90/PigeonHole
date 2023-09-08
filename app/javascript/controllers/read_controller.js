import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["button", "link"]
  connect() {
    console.log("Hello");
  }

  // mark() {
  //   fetch(this.linkTarget.action, {
  //     method: 'PATCH',
  //     headers: { "Accept": 'application/json' }
  // })
  // .then(response => {
  //   if(response.ok) {
  //     window.location.href = this.linkTarget;
  //   }
  // });
}
