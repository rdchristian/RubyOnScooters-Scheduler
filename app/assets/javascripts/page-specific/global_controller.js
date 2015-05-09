// Place all the behaviors and hooks related to a controller here.

// $(function() {

// To update the time when clicking outside the clockpicker, instead of selecting minutes
clockpicker_afterHide = function($clockpicker) {
    return function() {
        hours = $('.clockpicker-span-hours').html();
        mins  = $('.clockpicker-span-minutes').html();
        am_pm = $('.clockpicker-span-am-pm').html();
        $clockpicker.find('input').val(hours + ':' + mins + ' ' + am_pm);
    }
};

$('.clockpicker').clockpicker({
    placement: 'bottom',
    align: 'top',
    type: 'text',
    autoclose: 'true',
    twelvehour: 'true',
    afterHide: clockpicker_afterHide($('.clockpicker')),
});
$('.clockpicker-disabled-ampm').clockpicker({
    placement: 'bottom',
    align: 'top',
    type: 'text',
    autoclose: 'true',
    afterHide: clockpicker_afterHide($('.clockpicker-disabled-ampm')),
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

// });