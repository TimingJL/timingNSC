// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){

	//!!!! We define CLASS disabled_after_submit to disable button after form submit !!!!
	$('.disabled_after_submit').click(function(){
		$(this).addClass("disabled");
		$(this).click(false);
	});
});