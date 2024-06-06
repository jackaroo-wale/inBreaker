// // app/javascript/controllers/weekly_questions_controller.js
// import { Controller } from "@hotwired/stimulus"

// export default class extends Controller {
//   static targets = ["question", "result", "nextButton"]

//   connect() {
//     this.currentQuestionIndex = 0
//   }

//   selectAnswer(event) {
//     this.selectedAnswer = event.target.value
//     this.nextButtonTarget.disabled = false
//   }

//   nextQuestion() {
//     const currentQuestion = this.questionTargets[this.currentQuestionIndex]
//     const correctAnswer = currentQuestion.dataset.correctAnswer

//     if (this.selectedAnswer === correctAnswer) {
//       this.resultTarget.innerText = "Correct!"
//     } else {
//       this.resultTarget.innerText = "Wrong!"
//     }
//     this.resultTarget.classList.remove("d-none")

//     setTimeout(() => {
//       this.resultTarget.classList.add("d-none")
//       currentQuestion.classList.add("d-none")
//       this.currentQuestionIndex += 1

//       if (this.currentQuestionIndex < this.questionTargets.length) {
//         this.questionTargets[this.currentQuestionIndex].classList.remove("d-none")
//       } else {
//         this.resultTarget.innerText = "No more questions!"
//         this.resultTarget.classList.remove("d-none")
//       }
//     }, 1000)
//   }
// }

// app/javascript/controllers/weekly_questions_controller.js

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["questionCard"];

  connect() {
    this.currentQuestionIndex = 0;
    this.toggleCurrentQuestionVisibility();
  }

  toggleCurrentQuestionVisibility() {
    this.questionCardTargets.forEach((card, index) => {
      if (index === this.currentQuestionIndex) {
        card.classList.remove("d-none");
      } else {
        card.classList.add("d-none");
      }
    });
  }

  nextQuestion() {
    this.currentQuestionIndex++;
    if (this.currentQuestionIndex >= this.questionCardTargets.length) {
      this.currentQuestionIndex = 0;
    }
    this.toggleCurrentQuestionVisibility();
  }
}
