import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-initial-answers"
export default class extends Controller {
  connect() {
    console.log("connected")
  }
}



// import { Controller } from "@hotwired/stimulus"

// export default class extends Controller {
//   static targets = ["infos", "form"]

//   displayForm() {
//     this.infosTarget.classList.add("d-none")
//     this.formTarget.classList.remove("d-none")
//   }
// }
