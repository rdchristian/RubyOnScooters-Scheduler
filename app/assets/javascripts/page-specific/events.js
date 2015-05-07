// Place all the behaviors and hooks related to the events controller here.

// $(function() {
	
// Dynamic Ending datetime calculation using moment.js
$("[name='event[start_date]'], [name='event[start]'], [name='event[duration]']").change(function() {
	// Update the ending date field = event[ending]
	var start = moment($("[name='event[start_date]']").val() + $("[name='event[start]']").val(), "MMMM DD, YYYYHH:mm");
	var duration = moment.duration($("[name='event[duration]']").val());
	var ending = start.add(duration);
	$("[name='event[ending]']").val(ending.format("MMMM D, YYYY, h:mm A"));
});

// Recurring event form: sliding up and down depending on its checkbox
var $form = $('.hide-slide').hide();
var $checkbox = $('#recurrence_checked');
$checkbox.change(function() {
	if($checkbox.is(':checked'))
		$form.slideDown();
	else
		$form.slideUp();
}).change();


// Configuring common selectize parameters
var selectable_options = {
    persist: false,
    createOnBlur: true,
    create: false,
    highlight: true,
    maxOptions: 179, // Why 179? Fu, that's why
    sortField: { field: 'text', direction: 'asc' },
};
$('.selectable-facility').selectize(selectable_options);

// Configuring selectize for resources
selectable_options['render'] = {
    item: function(data, escape) {
        return  '<div class="item">' +
        					'<span class="item-label">' + escape(data.text) + '</span>' +
        					'<input type="text" class="item-input" value="1">' +
        				'</div>';
    }
};

var $resource_counts_field = $("[name='event[resource_counts]']");
var resource_counts = JSON.parse($resource_counts_field.val());
function update_counts() {
	$resource_counts_field.val(JSON.stringify(resource_counts));
}

var add_resource_item = function(value, $item) {
	$input = $item.find('.item-input');
	$input.TouchSpin({
    max: 1000,
    min: 1,
	});
	if(value === null) value = $item.data('value');
	$input.parent().addClass("item-number-picker");

	if(value in resource_counts)
		$input.val(resource_counts[value]);
	$input.on('change', function() {
		resource_counts[value] = $(this).val();
		update_counts();
	}).change();
};
selectable_options['onItemAdd'] = add_resource_item;

var remove_resource_item = function(value, $item) {
	delete resource_counts[value]
	update_counts();
};
selectable_options['onItemRemove'] = remove_resource_item;

$('.selectable-resource').selectize(selectable_options);

$('.selectable-resource .item').each(function() { add_resource_item(null, $(this)); });

// Focus on the input field inside the a selected resource upon clicking
$(document).on('click', 'div.selectize-input div.item', function(e) {
  // $(this).find('input').focus();
 	// $(this).addClass('active');
});

alert('hellow world');

// }); // document.ready

