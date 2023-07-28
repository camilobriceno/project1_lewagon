import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accordion"
export default class extends Controller {

  static targets = ["accordion"]


  connect() {
    console.log("Hello mate")
    console.log(this.accordionTargets)
    this.accordionExpander()
  }


  accordionExpander(){
    let i;
    for (i = 0; i < this.accordionTargets.length; i++) {
      this.accordionTargets[i].addEventListener("click", function (e) {


        e.currentTarget.classList.toggle("active");
        var panel = e.currentTarget.nextElementSibling;
        if (panel.style.maxHeight) {
          panel.style.maxHeight = null;
        } else {
          panel.style.maxHeight = panel.scrollHeight + "px";
        }
      });
    }
  }
}
