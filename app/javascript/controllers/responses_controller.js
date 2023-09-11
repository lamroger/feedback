import { Controller } from "@hotwired/stimulus"

const WAFFIE_AI_PROMPT_ID = "ec691235-a113-4d7b-9e65-6a2898f28fab"
export default class extends Controller {
  static targets = ["input", "result", "replace", "thumbsUp", "thumbsDown"]

  static values = {
    waffieAiEndpoint: String,
    waffieAiClientToken: String
  }

  replaceMessage() {
    const element = this.resultTarget
    const result = element.textContent

    const replaceElement = this.replaceTarget

    replaceElement.value = result
  }

  thumbsUp() {
    fetch(this.waffieAiEndpointValue, {
      method: "POST",
      body: JSON.stringify({
        feedback: {
          prompt_id: WAFFIE_AI_PROMPT_ID,
          label: "positive",
          input: this.inputTarget.value,
          output: this.resultTarget.textContent
        }
      }),
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${this.waffieAiClientTokenValue}`,
        "Accept": "application/json",
      }
    }).then(response => {
      console.log(response)
    })
  }

  thumbsDown() {
    fetch(this.waffieAiEndpointValue, {
      method: "POST",
      body: JSON.stringify({
        feedback: {
          prompt_id: WAFFIE_AI_PROMPT_ID,
          label: "negative",
          input: this.inputTarget.value,
          output: this.resultTarget.textContent
        }
      }),
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${this.waffieAiClientTokenValue}`,
        "Accept": "application/json",
      }
    }).then(response => {
      console.log(response)
    })
  }

}
