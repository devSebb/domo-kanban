import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "content"]

  connect() {
    this.activeTabClass = "active"
    this.hiddenClass = "hidden"
  }

  switchTab(event) {
    const clickedTab = event.currentTarget
    const tabId = clickedTab.dataset.tabId

    // Remove active class and set aria-selected to false for all buttons
    this.buttonTargets.forEach(button => {
      button.classList.remove(this.activeTabClass)
      button.setAttribute('aria-selected', 'false')
    })

    // Hide all content
    this.contentTargets.forEach(content => {
      content.classList.add(this.hiddenClass)
    })

    // Activate clicked tab
    clickedTab.classList.add(this.activeTabClass)
    clickedTab.setAttribute('aria-selected', 'true')

    // Show corresponding content
    const selectedContent = document.getElementById(tabId)
    if (selectedContent) {
      selectedContent.classList.remove(this.hiddenClass)
    }
  }
}
