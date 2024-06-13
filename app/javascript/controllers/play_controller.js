import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const questions = this.element.querySelectorAll('.question');
    const revealAnswerButtons = this.element.querySelectorAll('.reveal-answer');
    const labels = this.element.querySelectorAll('.form-check-label');

    revealAnswerButtons.forEach((button, index) => {
      button.addEventListener('click', () => {
        const currentQuestion = button.closest('.question');
        const correctAnswer = currentQuestion.querySelector('input[type="hidden"][name*="answer"]').dataset.answerText;
        const radios = currentQuestion.querySelectorAll('input[type="radio"][data-answer-group="answers"]');

        radios.forEach((radio) => {
          const label = currentQuestion.querySelector(`label[for="${radio.id}"]`);
          if (label) {
            if (radio.value === correctAnswer) {
              label.classList.add('correct-answer');
            } else {
              label.classList.add('wrong-answer');
            }
          }
        });

        button.classList.add('d-none');

        const nextButton = currentQuestion.querySelector('.next-question');
        if (nextButton) {
          nextButton.classList.remove('d-none');
          nextButton.addEventListener('click', (event) => {
            event.preventDefault();

            questions[index].classList.add('d-none');
            if (index < questions.length - 1) {
              questions[index + 1].classList.remove('d-none');
            } else {
              window.location.href = '<%= team_path(@team) %>';
            }

            nextButton.classList.add('d-none');
            if (revealAnswerButtons[index + 1]) {
              revealAnswerButtons[index + 1].classList.remove('d-none');
            }

            const nextQuestion = questions[index + 1];
            if (nextQuestion) {
              const nextRadios = nextQuestion.querySelectorAll('input[type="radio"][data-answer-group="answers"]');
              nextRadios.forEach(radio => {
                const label = nextQuestion.querySelector(`label[for="${radio.id}"]`);
                if (label) {
                  label.classList.remove('correct-answer', 'wrong-answer');
                  radio.checked = false;
                }
              });
            }
          });
        }
      });
    });

    labels.forEach(label => {
      label.addEventListener('click', () => {
        const radio = document.querySelector(`#${label.getAttribute('for')}`);
        if (radio) {
          radio.checked = true;

          const radios = this.element.querySelectorAll('input[type="radio"][data-answer-group="answers"]');
          radios.forEach(r => {
            const lbl = document.querySelector(`label[for="${r.id}"]`);
            if (lbl) {
              lbl.classList.remove('selected');
            }
          });

          label.classList.add('selected');
        }
      });
    });

    const radios = this.element.querySelectorAll('input[type="radio"][data-answer-group="answers"]');
    radios.forEach(radio => {
      radio.addEventListener('change', () => {
        if (radio.checked) {
          radios.forEach(r => {
            const label = this.element.querySelector(`label[for="${r.id}"]`);
            if (label) {
              label.classList.remove('selected');
            }
          });

          const label = this.element.querySelector(`label[for="${radio.id}"]`);
          if (label) {
            label.classList.add('selected');
          }
        }
      });
    });
  }
}
