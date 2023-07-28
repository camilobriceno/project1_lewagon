import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quantity"
export default class extends Controller {
  static targets = ["minus", "input", "plus", "price", "total", "superTotal"]

  connect() {
    this.calculator()
  }

  calculator(){
    this.plusTargets.forEach(btn=>{
      btn.addEventListener('click', ()=>{
        console.log("plus")
        btn.previousElementSibling.value++;
        let currenButtonValue = btn.previousElementSibling.value
        const price = Number.parseFloat(this.priceTarget.innerText)
        let total = price * currenButtonValue
        this.totalTarget.innerText = total.toFixed(2)
      })
    })

    this.minusTargets.forEach(btn=>{
      btn.addEventListener('click', ()=>{
        console.log("minus")
          btn.nextElementSibling.value = (btn.nextElementSibling.value == 0) ? 0 : btn.nextElementSibling.value - 1;
          let currenButtonValue = btn.nextElementSibling.value
          const price = Number.parseFloat(this.priceTarget.innerText)
          let otherTotal = price * currenButtonValue
          this.totalTarget.innerText = otherTotal.toFixed(2)
        })
   })
  }
  calculateTotal(){
    console.log("test")
  }
}
