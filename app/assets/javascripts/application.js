// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require twitter/bootstrap
//= require selectize
//= require moment
//= require underscore/underscore
//= require bootstrap-datetimepicker
//= require bootstrap-calendar/js/calendar
//= require bootstrap-3-timepicker/js/bootstrap-timepicker
//= require bootstrap-touchspin/dist/jquery.bootstrap-touchspin
//= require bootstrap-daterangepicker/daterangepicker
//= require bootstrapformhelpers/js/bootstrap-formhelpers
//= require_tree ../../../vendor/assets/javascripts/.
//= require loading_spinner
//= require turbolinks
//= require turboboost


// For loading the site images in the modal
function imageLoader(img_name, $element) {
  var img = $("<img />").attr('src', '/images/' + img_name)
      .load(function() {
          if (!this.complete || typeof this.naturalWidth == "undefined" || this.naturalWidth == 0) {
              console.log('broken image!');
          } else {
              $element.html(img);
          }
      }).addClass('img-responsive');
}

$(function() {

// Pretty much a hack to make the sidebar work with bh
$('.nav-sidebar').removeClass('nav-tabs');


$('#map-modal').on('shown.bs.modal', function() {
  // debugger;
  imageLoader('first_floor.JPG',  $('#image-map1'));
  imageLoader('second_floor.JPG', $('#image-map2'));
})
  
});

