import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["results", "selectedMembers"];

  connect() {
    console.log("STFU")
    console.log(this.loadAllUsers())
    this.loadAllUsers();
  }

  loadAllUsers() {
    fetch("/users", {
      headers: { "Accept": "text/html" }
    })
    .then(response => response.text())
    .then(users => this.displayUsers(users));
  }

  displayUsers(usersHtml) {
  const parser = new DOMParser();
  const doc = parser.parseFromString(usersHtml, 'text/html');
  const userDivs = doc.body.querySelectorAll('div');
  const users = Array.from(userDivs).map(div => {
    const [email, id] = div.textContent.trim().split(' ');
    return { email, id };
  });

  console.log(typeof users); // logs "object" (an array of user objects)

  this.resultsTarget.innerHTML = users.map(user => {
    return `<div>
              ${user.email} <button type="button" data-action="click->user-search#add" data-user-id="${user.id}" data-user-email="${user.email}">Add</button>
            </div>`
  }).join("");
}

  perform(event) {
    const email = event.target.value.trim();

    if (email.length > 2) {
      fetch(`/users/search?email=${email}`, {
        headers: { "Accept": "text/html" }
      })
      .then(response => response.text())
      .then(users => this.displayUsers(users));
    } else {
      this.loadAllUsers();
    }
  }

  add(event) {
    const userId = event.target.dataset.userId;
    const userEmail = event.target.dataset.userEmail;
    const userHtml = `<div>${userEmail} <input type="hidden" name="team[user_ids][]" value="${userId}"></div>`;
    this.selectedMembersTarget.insertAdjacentHTML("beforeend", userHtml);
  }
}
