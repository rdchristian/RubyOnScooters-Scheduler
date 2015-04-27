// Place all the behaviors and hooks related to a controller here.

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
    max: 1000,
    verticalbuttons: true,
    verticalupclass: 'glyphicon glyphicon-chevron-up',
    verticaldownclass: 'glyphicon glyphicon-chevron-down',
});

$('.timepicker').timepicker({
    minuteStep: 15,
    showMeridian: false,
    defaultTime: '0:0',
    showInputs: true,
});

$('.single-datepicker').daterangepicker({
    singleDatePicker: true,
    showDropdowns: true,
    minDate: moment(),
    format: 'MMMM D, YYYY',
});

$().bfhdatepicker('toggle');
$().bfhtimepicker('toggle');
$().bfhselectbox('toggle');

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
