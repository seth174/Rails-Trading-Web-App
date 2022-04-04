// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import "chartkick/chart.js"

let popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
let popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
  return new bootstrap.Popover(popoverTriggerEl);
});

// buttons = document.getElementById('test');
//
// alert(buttons);
//
// // for(let i = 0; i < buttons.length; i++){
// //   buttons[i].onclick = function(){highlight(buttons[i])};
// // }
//
// buttons.onclick = function(){highlight(buttons)};
//
// // function highlight(button){
// //   if(button.classList.contains('btn-primary')){
// //     alert('yes');
// //   }
// //   button.removeClass('btn-primary').addClass('btn-secondary');
// //   if(button.classList.contains('btn-secondary')){
// //     alert('yes');
// //   }
// // }
//
// $(document).ready(function () {
// 	$('#test').on('click', function() {
//     $('#test').removeClass('btn-primary');
//     $(this).addClass('btn-secondary');
//   });
// });
//
// document.addEventListener("turbolinks:load", () => {
//   alert("page has loaded!");
// });
