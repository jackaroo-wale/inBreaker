import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "question",
    "labels",
    "radios"
  ];

  connect() {
    console.log("Connected");
    this.attachLabelHandlers();
    this.attachRadioHandlers();
    this.attachDoneButtonHandler();
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

  attachDoneButtonHandler() {
    const doneButton = this.element.querySelector('.reveal-answer');
    if (doneButton) {
      doneButton.addEventListener('click', (event) => {
        event.preventDefault();
        this.highlightCorrectAnswers();

      });
    }
  }

  handleLabelClick(label) {
    const radio = document.querySelector(`#${label.getAttribute('for')}`);
    if (radio) {
      radio.checked = true;
      this.labelsTargets.forEach(lbl => {
        lbl.classList.remove('selected');
      });
      label.classList.add('selected');
    }
  }

  revealAnswer(event) {
    event.preventDefault();
    const form = event.target.closest('form')
    console.log(form)
    const nextButtons = document.querySelectorAll('.next-question');
    const revealAnswerButtons = document.querySelectorAll('.reveal-answer');

    fetch(form.action, {
      method: 'POST',
      body: new FormData(form),
      headers: {
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
      }
    }).then(response => {
      if (response.ok) {
        nextButtons.forEach(lbl => {
          lbl.classList.toggle('d-none');
        })

        revealAnswerButtons.forEach(lbl => {
          lbl.classList.toggle('d-none');
        })
      } else {
        console.log("fuck this!!!!!")
      }
    })
  }

  handleRadioChange(radio) {
    if (radio.checked) {
      this.labelsTargets.forEach(lbl => {
        lbl.classList.remove('selected');
      });
      const label = document.querySelector(`label[for="${radio.id}"]`);
      if (label) {
        label.classList.add('selected');
      }
    }
  }

  highlightCorrectAnswers() {
    this.labelsTargets.forEach(label => {
      if (label.classList.contains('correct')) {
        label.classList.add('correct-answer');
      } else {
        label.classList.add('wrong-answer');
      }
    });
  }
}
