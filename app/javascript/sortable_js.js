// import Sortable from 'sortablejs/modular/sortable.complete.esm.js';
import Sortable from 'sortablejs';

document.addEventListener('turbo:load', () => {
  const cardLists = document.querySelectorAll('.card-list');

  cardLists.forEach(cardList => {
    new Sortable(cardList, {
      group: 'shared',
      animation: 150,
      draggable: '.card',
      onEnd: function (evt) {
        const cardId = evt.item.dataset.cardId;
        const newListId = evt.to.dataset.listId;
        const newPosition = Array.from(evt.to.children).indexOf(evt.item) + 1;

        updateCardPosition(cardId, newListId, newPosition);
      }
    });
  });
});

function updateCardPosition(cardId, listId, position) {
  const url = `/cards/${cardId}/update_position`;
  const data = {
    card: {
      list_id: listId,
      position: position
    }
  };

  fetch(url, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
    },
    body: JSON.stringify(data)
  }).then(response => {
    if (!response.ok) {
      console.error('Failed to update card position');
    }
  }).catch(error => {
    console.error('Error updating card position:', error);
  });
}
