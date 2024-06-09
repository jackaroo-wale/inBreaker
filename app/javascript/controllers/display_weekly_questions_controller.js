import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["question", "nextButton"];

  connect() {
    console.log("Question controller initialized");
    this.hideAllQuestionsExceptFirst();
  }

  hideAllQuestionsExceptFirst() {
    console.log("Hiding all questions except the first one");
    this.questionTarget.forEach((question, index) => {
      console.log(question)
      if (index !== 0) {
        question.style.display = "none";
      }
    });
  }

  nextQuestion(event) {
    console.log("Next question clicked");
    const currentQuestion = event.target.closest(".question");
    const nextQuestion = currentQuestion.nextElementSibling;

    if (nextQuestion) {
      console.log("Displaying next question");
      currentQuestion.style.display = "none";
      nextQuestion.style.display = "block";
    } else {
      console.log("No more questions to display");
      // Handle case when all questions have been shown
    }
  }
}
