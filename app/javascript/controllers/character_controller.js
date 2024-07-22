import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="character"
export default class extends Controller {
  static targets = [ "input" ]

  connect() {
    console.log(this.inputTargets)
  }

  disabled() {
      // 1-lire la valeur de l'input qui vient d'etre changer
      this.inputTarget.value
      // 2-cette valeur passe en disabled pour les autres input
        // 2.2 selectionner tout les input exepté celui qui a été changer
        // 2.3 pour chacun de ces input
          // 2.3.1 je selectionne l'option qui a le data disabled
            // 2.3.1.1 je lui enleve le data set disabled
          // 2.3.2 aller chercher l'option qui a la valeur de l'input actuel
          // 2.3.3 passe le data disabled comme disabled
    console.log(this.inputTarget.value)
    console.log(this.inputTargets(":not(this.inputTarget)"))
  }
}
