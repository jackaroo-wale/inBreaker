import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "questions",         // Targeting each question container
    "labels",            // Targeting labels for answer options
    "revealAnswerButton",// Targeting the reveal answer button
    "nextButton",        // Targeting the next button
    "radios"             // Targeting radio buttons for answers
  ];

  connect() {
    console.log("Connected");

    // Attach event listeners
    this.attachLabelHandlers();
    this.attachRadioHandlers();
  }

  attachLabelHandlers() {
    this.labelsTargets.forEach(label => {
      label.addEventListener('click', () => {
        this.handleLabelClick(label);
      });
    });
  }

  attachRadioHandlers() {
    this.radiosTargets.forEach(radio => {
      radio.addEventListener('change', () => {
        this.handleRadioChange(radio);
      });
    });
  }

  handleLabelClick(label) {
    const radio = document.querySelector(`#${label.getAttribute('for')}`);
    if (radio) {
      radio.checked = true;

      // Remove 'selected' class from all labels
      this.labelsTargets.forEach(lbl => {
        lbl.classList.remove('selected');
      });

      // Add 'selected' class to clicked label
      label.classList.add('selected');
    }
  }

  handleRadioChange(radio) {
    if (radio.checked) {
      // Remove 'selected' class from all labels
      this.labelsTargets.forEach(lbl => {
        lbl.classList.remove('selected');
      });

      // Find label corresponding to the checked radio and add 'selected' class
      const label = document.querySelector(`label[for="${radio.id}"]`);
      if (label) {
        label.classList.add('selected');
      }
    }
  }

  revealAnswer(event) {
    event.preventDefault();

    const form = event.target.closest('form');
    if (!form) {
      console.error('Form element not found');
      return;
    }

    const currentQuestion = form.closest('.question');
    if (!currentQuestion) {
      console.error('Current question element not found');
      return;
    }

    const correctAnswer = this.getCorrectAnswer(currentQuestion);

    this.highlightAnswers(currentQuestion, correctAnswer);

    this.nextButtonTarget.classList.remove('d-none');
    this.revealAnswerButtonTarget.classList.add('d-none');
  }

  getCorrectAnswer(currentQuestion) {
    const correctAnswerInput = currentQuestion.querySelector('input[type="hidden"][name*="answer-text"]');
    if (!correctAnswerInput) {
      console.error('Correct answer input not found in current question:', currentQuestion);
      return null;
    }
    return correctAnswerInput.dataset.answerText;
  }

  highlightAnswers(currentQuestion, correctAnswer) {
    this.radiosTargets.forEach(radio => {
      const label = currentQuestion.querySelector(`label[for="${radio.id}"]`);
      if (label) {
        label.classList.remove('correct-answer', 'wrong-answer');
        if (radio.value === correctAnswer) {
          label.classList.add('correct-answer');
        } else {
          label.classList.add('wrong-answer');
        }
      }
    });
  }
}
