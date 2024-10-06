import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
    console.log("InviteFormController connected")
  }

  toggleForm() {
    console.log("Toggling form")
    this.formTarget.classList.toggle('hidden')
  }

  hideForm() {
    console.log("Hiding form")
    this.formTarget.classList.add('hidden')
  }
}
