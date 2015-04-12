// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$('.selectable').selectize({
    persist: false,
    createOnBlur: true,
    create: false,
    highlight: true,
    maxOptions: 179, // Why 179? Fu, that's why
    sortField: { field: 'text', direction: 'asc' },
});

var clockpicker_params = {
    placement: 'bottom',
    align: 'top',
    type: 'text',
    autoclose: 'true',
};
$('.clockpicker-disable-am-pm').clockpicker(clockpicker_params);

clockpicker_params['twelvehour'] = 'true';
$('.clockpicker').clockpicker(clockpicker_params);


$(".number-picker").TouchSpin({
    verticalbuttons: true,
    verticalupclass: 'glyphicon glyphicon-chevron-up',
    verticaldownclass: 'glyphicon glyphicon-chevron-down',
});


$('.single-datepicker').daterangepicker({
    singleDatePicker: true,
    showDropdowns: true,
    minDate: moment(),
});


// Forward the click on the tiny calendar icon to the date picker
$('.click-date').click(function() {
    $('.single-datepicker').click();
});

// To make them uneditable, but still looking 'enabled'
$('.single-datepicker, .clockpicker :input').attr('readonly', true);
$('.single-datepicker, .clockpicker :input').css({
    'cursor': 'pointer',
    'background-color': '#FFFFFF',
});
