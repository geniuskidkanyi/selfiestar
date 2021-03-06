// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require ahoy
//= require Chart.bundle
//= require chartkick
//= require jquery_ujs
//= require turbolinks
//= require toastr
//= require_tree .

$(document).on('ready turbolinks:load', function() {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#avatar-upload").change(function(){
    $('.img_prev').removeClass('hidden');
    readURL(this);
  });
  $('.main-carousel').flickity({
  // options
  cellAlign: 'right',
  contain: true,
  wrapAround: true,
  arrowShape: {
  x0: 10,
  x1: 60, y1: 50,
  x2: 65, y2: 45,
  x3: 20
}
});
});
$(document).on("dragover drop", function(e) {
    e.preventDefault();
}).on("drop", function(e) {
    $("input[type='file']")
        .prop("files", e.originalEvent.dataTransfer.files)
        .closest("form")
});

$(document).on('ready turbolinks:load', function() {
  return $("a").bind("ajax:error", function(event, jqXHR, ajaxSettings, thrownError) {
    if (jqXHR.status === 401) {
      return window.location.replace('/login');
    }
  });
});
