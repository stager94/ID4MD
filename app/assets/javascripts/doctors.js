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
//= require sync
//= require moment-with-locales
//= require ui/main
//= require inobounce
//= require angular.min
//= require angular-resource.min
//= require angular-route.min
//= require angular-sanitize.min
//= require angular-ui-router.min
//= require angular-simple-format
//= require angular-filter
//= require angular/doctors/app
//= require_tree ./angular/doctors

var $document = $($document);

$(document).ready(function(){
  SwipedPatientsPanels.initialize();
});


var reloadFunction = function() {
  Page.onResize();
  HeadersFilters.initialize();
  floatedOptions.initialize();
  $('.scrollable').scroll(function(){
		Page.checkScroll();
	})
}

$(reloadFunction);
$(document).on('ngready', reloadFunction);


$(window).on('resize', Page.onResize);
