// Place all the behaviors and hooks related to the events controller here.


$("[name='event[start_date]'], [name='event[start]'], [name='event[duration]']").change(function(){
	// Update the end date field = event[end]
	var start = moment($("[name='event[start_date]']").val() + $("[name='event[start]']").val(), "MMMM DD, YYYYHH:mm");
	var duration = moment.duration($("[name='event[duration]']").val());
	var end = start.add(duration);
	$("[name='event[end]']").val(end.format("MMMM D, YYYY, h:mm A"));
});