import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["messages"]

  connect() {
    this.element.addEventListener('scroll', this.handleScroll.bind(this))
    this.page = 1
    this.loading = false
    this.hasMore = true
    this.scrollToBottom()
  }

  scrollToBottom() {
    requestAnimationFrame(() => {
      this.element.scrollTop = this.element.scrollHeight
    })
  }

  handleScroll() {
    const scrollTop = this.element.scrollTop
    const threshold = 100 // pixels from top

    if (scrollTop <= threshold && !this.loading && this.hasMore) {
      this.loadMoreMessages()
    }
  }

  loadMoreMessages() {
    this.loading = true
    const userId = this.element.dataset.userId
    this.page += 1

    fetch(`/messages?user_id=${userId}&page=${this.page}`, {
      headers: {
        'Accept': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.messages && data.messages.length > 0) {
        const currentScrollHeight = this.element.scrollHeight
        const scrollPosition = this.element.scrollTop

        const messagesContainer = this.element.querySelector('#messages-container')
        messagesContainer.insertAdjacentHTML('afterbegin', data.messages)

        // Maintain scroll position
        const newScrollHeight = this.element.scrollHeight
        this.element.scrollTop = scrollPosition + (newScrollHeight - currentScrollHeight)

        this.hasMore = data.has_more
      } else {
        this.hasMore = false
      }
      this.loading = false
    })
    .catch(error => {
      console.error('Error loading messages:', error)
      this.loading = false
    })
  }

  disconnect() {
    this.element.removeEventListener('scroll', this.handleScroll.bind(this))
  }
}
