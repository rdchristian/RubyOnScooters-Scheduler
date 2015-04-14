// Place all the behaviors and hooks related to a controller here.

var selectable_options = {
    persist: false,
    createOnBlur: true,
    create: false,
    highlight: true,
    maxOptions: 179, // Why 179? Fu, that's why
    sortField: { field: 'text', direction: 'asc' },
};
$('.selectable-facility').selectize(selectable_options);
$('.selectable-resource').selectize(selectable_options);

$('.clockpicker').clockpicker({
    placement: 'bottom',
    align: 'top',
    type: 'text',
    autoclose: 'true',
    twelvehour: 'true',
});

$('.clockpicker-disabled-ampm').clockpicker({
    placement: 'bottom',
    align: 'top',
    type: 'text',
    autoclose: 'true',
});

$(".number-picker").TouchSpin({
    verticalbuttons: true,
    verticalupclass: 'glyphicon glyphicon-chevron-up',
    verticaldownclass: 'glyphicon glyphicon-chevron-down',
});

$('.timepicker').timepicker({
    minuteStep: 15,
    showMeridian: false,
    defaultTime: false,
    showInputs: true,
});

$('.single-datepicker').daterangepicker({
    singleDatePicker: true,
    showDropdowns: true,
    minDate: moment(),
    format: 'MMMM D, YYYY',
});


// Forward the click on the tiny calendar icon to the date picker
$('.click-date').click(function() {
    $('.single-datepicker').click();
});

// To make them uneditable, but still looking 'enabled'
var disabled_text_fields = '.single-datepicker, .clockpicker :input';
$(disabled_text_fields).attr('readonly', true);
$(disabled_text_fields).css({
    'cursor': 'pointer',
    'background-color': '#FFFFFF',
});
