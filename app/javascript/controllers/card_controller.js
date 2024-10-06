import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["cardDetails", "cardForm", "truncatedDescription", "fullDescription"]

  toggleCardDetails(event) {
    const cardElement = event.currentTarget
    const cardId = cardElement.dataset.cardId
    const detailsElement = this.cardDetailsTargets.find(target => target.id === `card-details-${cardId}`)
    const truncatedDescription = cardElement.querySelector('[data-card-target="truncatedDescription"]')
    const fullDescription = cardElement.querySelector('[data-card-target="fullDescription"]')

    detailsElement.classList.toggle('hidden')

    if (truncatedDescription && fullDescription) {
      truncatedDescription.classList.toggle('hidden')
      fullDescription.classList.toggle('hidden')
    }
  }

  toggleCardForm(event) {
    const listId = event.currentTarget.dataset.listId
    const formElement = this.cardFormTargets.find(target => target.id === `cardForm${listId}`)
    formElement.classList.toggle('hidden')
  }
}
