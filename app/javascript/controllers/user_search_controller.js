import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-search"
export default class extends Controller {
  static targets = ["results", "selectedMembers"]

  search(event) {
    const query = event.target.value

    fetch(`/users/search?q=${query}`)
    .then(response => response.json())
    .then(users => {
      this.resultsTarget.innerHTML = ''
      users.forEach(user => {
        const userElement = document.createElement('div')
        userElement.textContent = user.email
        userElement.addEventListener('click', () => this.addUserToTeam(user))
        this.resultsTarget.appendChild(userElement)
      });
    })
  }

  addUserToTeam(user) {
    if (!this.userExistInMember(user_id)) {
      const userElement = document.createElement('div')
      userElement.textContent = user.email
      this.selectedMembersTarget.appendChild(userElement)
      const inputElement = document.createElement('input')
      inputElement.type = 'hidden'
      inputElement.name = 'user_ids[]'
      inputElement.value = user.id
      this.element.appendChild(inputElement)
    }
  }

  userExistInMember(userId) {
    return Array.from(this.selectedMembersTarget.children).somw(child => {
      return child.dataset.userId === userId
    })
  }
}
