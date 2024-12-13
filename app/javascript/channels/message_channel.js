import consumer from "./consumer"

document.addEventListener('turbo:load', () => {
  const messagesContainer = document.getElementById('messages')

  if (messagesContainer) {
    const messageForm = document.querySelector('.new-message-form')
    const messageInput = messageForm?.querySelector('textarea')

    // Handle form submission
    messageForm?.addEventListener('submit', (e) => {
      e.preventDefault()

      const formData = new FormData(messageForm)

      fetch(messageForm.action, {
        method: 'POST',
        body: formData,
        headers: {
          'X-CSRF-Token': document.querySelector("[name='csrf-token']").content,
          'Accept': 'application/json'
        },
        credentials: 'same-origin'
      })
      .then(response => response.json())
      .then(data => {
        if (!data.error) {
          // Add message to container
          messagesContainer.insertAdjacentHTML('beforeend', data.message)
          // Clear input
          messageInput.value = ''
          // Scroll to bottom
          messagesContainer.scrollTop = messagesContainer.scrollHeight
        }
      })
    })

    // Action Cable subscription
    consumer.subscriptions.create({
      channel: "MessageChannel",
      room: messagesContainer.dataset.userId
    }, {
      connected() {
        console.log("Connected to MessageChannel")
      },

      disconnected() {
        console.log("Disconnected from MessageChannel")
      },

      received(data) {
        console.log("Received message:", data)
        // Only add the message if it's from the other user
        if (data.sender_id !== parseInt(messagesContainer.dataset.currentUserId)) {
          messagesContainer.insertAdjacentHTML('beforeend', data.message)
          messagesContainer.scrollTop = messagesContainer.scrollHeight
        }
      }
    })

    // Initial scroll to bottom
    messagesContainer.scrollTop = messagesContainer.scrollHeight
  }
})
