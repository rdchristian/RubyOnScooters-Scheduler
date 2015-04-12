// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$('.selectable').selectize({
	persist: false,
	createOnBlur: true,
	create: false,
	highlight: true,
	maxOptions: 179, // Why 179? Fu, that's why
	sortField: { field: 'text', direction: 'asc' }
});