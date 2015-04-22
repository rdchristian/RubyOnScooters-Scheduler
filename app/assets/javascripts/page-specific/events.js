// Place all the behaviors and hooks related to the events controller here.

$(document).ready(function(){

// Dynamic Ending datetime calculation using moment.js
$("[name='event[start_date]'], [name='event[start]'], [name='event[duration]']").change(function(){
	// Update the ending date field = event[ending]
	var start = moment($("[name='event[start_date]']").val() + $("[name='event[start]']").val(), "MMMM DD, YYYYHH:mm");
	var duration = moment.duration($("[name='event[duration]']").val());
	var ending = start.add(duration);
	$("[name='event[ending]']").val(ending.format("MMMM D, YYYY, h:mm A"));
});

// Recurring event forms
var $form = $('.hide-slide').hide();
var $checkbox = $('#recurrence_checked');
$checkbox.change(function(){
	if($checkbox.is(':checked'))
		$form.slideDown();
	else
		$form.slideUp();
}).change();



}); // document.ready