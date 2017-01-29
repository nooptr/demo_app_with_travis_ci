// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var ready;
ready = function() {
  $(".deactivated").hide();
  $("#user_locked_locked").click(function(){
        $(".deactivated").show();
  });
  $("#user_locked_active").click(function(){
    $(".deactivated").hide();
  });
  $("#user_image").change(function(){
	});
  $("#user_remove_image").click(function(){
    $("#preview_image").toggle();
  });
};
$(document).ready(ready);
$(document).on('page:load', ready);

function readURL(input) {
	if (input.files && input.files[0]) {
  	var reader = new FileReader();
    reader.onload = function (e) {
    document.getElementById('display').src=e.target.result;
    }
    reader.readAsDataURL(input.files[0]);
  }
}