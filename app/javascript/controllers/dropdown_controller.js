import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "menu"]

  connect() {
    this.adjustMenuWidth()
    window.addEventListener('resize', this.adjustMenuWidth.bind(this))
  }

  disconnect() {
    window.removeEventListener('resize', this.adjustMenuWidth.bind(this))
  }

  adjustMenuWidth() {
    const buttonWidth = this.buttonTarget.offsetWidth
    this.menuTarget.style.width = `${buttonWidth}px`
  }
}
