import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="password-toggle"
export default class extends Controller {
  static targets = ["password", "eyeOpen", "eyeClosed"]

  toggle(event) {
    event.preventDefault()

    if (this.passwordTarget.type === "password") {
      this.passwordTarget.type = "text"
      this.eyeOpenTarget.classList.add("hidden")
      this.eyeClosedTarget.classList.remove("hidden")
    } else {
      this.passwordTarget.type = "password"
      this.eyeOpenTarget.classList.remove("hidden")
      this.eyeClosedTarget.classList.add("hidden")
    }
  }
}
