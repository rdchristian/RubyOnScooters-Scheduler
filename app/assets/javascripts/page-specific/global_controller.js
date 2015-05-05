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

var datepicker_params = {
    singleDatePicker: true,
    showDropdowns: true,
    minDate: moment(),
    format: 'MMMM D, YYYY',
};
$('.single-datepicker:not(.up-datepicker)').daterangepicker(datepicker_params);
datepicker_params['drops'] = 'up';
$('.single-datepicker.up-datepicker').daterangepicker(datepicker_params);

$().bfhdatepicker('toggle');
$().bfhtimepicker('toggle');
$().bfhselectbox('toggle');

// Forward the click on the tiny calendar icon to the date picker
$('.click-date').click(function(e) {
    $(this).siblings('.single-datepicker').click();
});

// To make them uneditable, but still looking 'enabled'
var disabled_text_fields = '.single-datepicker, .clockpicker :input';
$(disabled_text_fields).attr('readonly', true);
$(disabled_text_fields).css({
    'cursor': 'pointer',
    'background-color': '#FFFFFF',
});
