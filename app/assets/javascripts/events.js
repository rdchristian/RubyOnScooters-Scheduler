# Place all the behaviors and hooks related to the events controller here.


$('[name=event[start_date]], [name=event[start_time]], [name=event[duration]]').change(function(){
	// Update the end date field = event[end]
	var start_date_input = $('[name=event[start_date]]').val();
	var start_time_input = $('[name=event[start_time]]').val();
	var duration_input   = $('[name=event[duration]]').val();

	console.log([start_time_input, start_time_input, duration_input]);
});