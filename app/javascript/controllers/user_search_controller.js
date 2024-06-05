import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["results", "selectedMembers", "input"];

  connect() {
    this.loadAllUsers();
  }

  loadAllUsers() {
    fetch("/users", {
      headers: { "Accept": "text/html" }
    })
    .then(response => response.text())
    .then(usersHtml => this.displayUsers(usersHtml))
    .catch(error => console.error("Error fetching users:", error));
  }

  displayUsers(usersHtml) {
    const parser = new DOMParser();
    const doc = parser.parseFromString(usersHtml, 'text/html');
    const userDivs = doc.body.querySelectorAll('div');

    const users = Array.from(userDivs).map(div => {
      const emailElement = div.querySelector('.user-email');
      const idElement = div.querySelector('.user-id');

      if (!emailElement || !idElement) {
        return null;
      }

      const email = emailElement.textContent.trim();
      const id = idElement.textContent.trim();
      return { email, id };
    }).filter(user => user !== null);

    this.resultsTarget.innerHTML = users.map(user => {
      return `<div data-user-id="${user.id}">
                ${user.email} <button type="button" data-action="click->user-search#add" data-user-id="${user.id}" data-user-email="${user.email}">Add</button>
              </div>`;
    }).join("");
  }

  perform(event) {
    const email = event.target.value.trim();

    if (email.length >= 3) {
      fetch(`/users/search?email=${email}`, {
        headers: { "Accept": "text/html" }
      })
      .then(response => response.text())
      .then(usersHtml => {
        if (usersHtml.trim() === '') {
          this.resultsTarget.innerHTML = "<p>No users found</p>";
        } else {
          this.displayUsers(usersHtml);
        }
      })
      .catch(error => {
        console.error("Error fetching search results:", error);
        this.resultsTarget.innerHTML = "<p>Error fetching search results</p>";
      });
    } else if (email.length === 0) {
      this.loadAllUsers();
    } else {
      this.resultsTarget.innerHTML = "";
    }
}


  add(event) {
    const userId = event.target.dataset.userId;
    const userEmail = event.target.dataset.userEmail;
    const userHtml = `<div data-user-id="${userId}" data-user-email="${userEmail}">
                        ${userEmail} <button type="button" data-action="click->user-search#remove" data-user-id="${userId}" data-user-email="${userEmail}">Remove</button>
                        <input type="hidden" name="team[user_ids][]" value="${userId}">
                      </div>`;

    this.selectedMembersTarget.insertAdjacentHTML("beforeend", userHtml);
    this.removeUserFromResults(userId);
  }

  remove(event) {
    const userId = event.target.dataset.userId;
    const userEmail = event.target.dataset.userEmail;

    const selectedMember = this.selectedMembersTarget.querySelector(`[data-user-id="${userId}"]`);
    if (selectedMember) {
      selectedMember.remove();
    }

    const userHtml = `<div data-user-id="${userId}">
                        ${userEmail} <button type="button" data-action="click->user-search#add" data-user-id="${userId}" data-user-email="${userEmail}">Add</button>
                      </div>`;
    this.resultsTarget.insertAdjacentHTML("beforeend", userHtml);
  }

  removeUserFromResults(userId) {
    const userDiv = this.resultsTarget.querySelector(`[data-user-id="${userId}"]`);
    if (userDiv) {
      userDiv.remove();
    }
  }
}
