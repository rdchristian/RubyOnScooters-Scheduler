
// var calendar = $(".calendar").calendar({
//   tmpl_path: "/assets/bootstrap-calendar/tmpls/",
//   events_source: function () { return []; },
//   modal: "#events-modal",

// });

(function($) {

  "use strict";

  var options = {
    events_source: JSON.parse($('#events-array').val()),
    view: 'month',
    tmpl_path: '/assets/tmpls/',
    tmpl_cache: false,
    day: $('#starting-date').val(),
    modal: '#events-modal',
    modal_type: 'ajax',
    modal_title: function(event) { return event.title },
    onAfterEventsLoad: function(events) {
      if(!events) {
        return;
      }
      var list = $('#eventlist');
      list.html('');

      $.each(events, function(key, val) {
        $(document.createElement('li'))
          .html('<a href="' + val.url + '">' + val.title + '</a>')
          .appendTo(list);
      });
    },
    onAfterViewLoad: function(view) {
      $('h3.head-title').text(this.getTitle());
      $('.btn-group button').removeClass('active');
      $('button[data-calendar-view="' + view + '"]').addClass('active');
    },
    classes: {
      months: {
        general: 'label'
      }
    }
  };

  var calendar = $('#calendar').calendar(options);

  $('.btn-group button[data-calendar-nav]').each(function() {
    var $this = $(this);
    $this.click(function() {
      calendar.navigate($this.data('calendar-nav'));
    });
  });

  $('.btn-group button[data-calendar-view]').each(function() {
    var $this = $(this);
    $this.click(function() {
      calendar.view($this.data('calendar-view'));
    });
  });

  $('#first_day').change(function(){
    var value = $(this).val();
    value = value.length ? parseInt(value) : null;
    calendar.setOptions({first_day: value});
    calendar.view();
  });

  // $('#events-in-modal').change(function(){
  //   var val = $(this).is(':checked') ? $(this).val() : null;
  //   calendar.setOptions({modal: val});
  // });
  $('#events-modal .modal-header, #events-modal .modal-footer').click(function(e){
    //e.preventDefault();
    //e.stopPropagation();
  });


}(jQuery));