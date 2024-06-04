// src/controllers/nav_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["burger", "navbarLinks", "navContainer"]

  connect() {
    this.burger.addEventListener('click', this.toggleNav.bind(this))
  }

  toggleNav() {
    this.navLinksTarget.classList.toggle('nav-links-active')
    this.navContainerTarget.classList.toggle('nav-container-active')

    this.navLinksTargets.forEach((link, index) => {
      if (link.style.animation) {
        link.style.animation = ''
      } else {
        link.style.animation = `nav-link-fade 0.5s ease forwards ${index / 7 + 0.4}s`
      }
    })
  }
}
