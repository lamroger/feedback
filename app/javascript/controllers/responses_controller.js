import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["result", "replace"]
  replaceMessage() {
    const element = this.resultTarget
    const result = element.textContent

    const replaceElement = this.replaceTarget

    replaceElement.value = result
  }
}
