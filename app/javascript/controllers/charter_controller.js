import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto';


// Connects to data-controller="charter"
export default class extends Controller {

  static targets = ["canvas"]

  connect() {
    new Chart(this.canvasTarget, {
      type: 'doughnut',
      data: {
        labels: [
          'Red',
          'Blue',
          'Yellow',
          'Test'
        ],
        datasets: [{
          label: 'My First Dataset',
          data: [300, 50, 100, 200],
          backgroundColor: [
            'rgb(210,231,250)',
            'rgb(228,208,249)',
            'rgb(208,246,224)',
            'rgb(225,225,225)'
          ],
          hoverOffset: 4
        }]
      },
      options: {
        legend: {
          display: false
        },
        tooltips: {
          enabled: false
        },
        cutout: 120
      }
    });
  }
}
