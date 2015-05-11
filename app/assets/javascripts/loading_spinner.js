this.PageSpinner = {
  spin: function(ms) {
    var _this = this;
    if (ms == null) {
      ms = 500;
    }
    this.spinner = setTimeout((function() {
      return _this.add_spinner();
    }), ms);
    return $(document).on('page:change', function() {
      return _this.remove_spinner();
    });
  },
  spinner_html: '\
    <div class="modal fade" id="page-spinner">\
      <div class="vertical-alignment-helper">\
        <div class="modal-dialog vertical-align-center">\
          <div class="modal-content">\
            <div class="modal-header">\
              <h4 class="modal-title">Please wait</h4>\
            </div>\
            <div class="modal-body">\
              <i class="fa fa-spinner fa-spin fa-2x"></i>\
              &emsp;Loading...\
            </div>\
          </div>\
        </div>\
      </div>\
    </div>\
  ',
  spinner: null,
  add_spinner: function() {
    if($('#page-spinner').length) return this.spinner;
    if($('.modal').is(':visible')) return this.spinner;
    $('body').append(this.spinner_html);
    return $('body div#page-spinner').modal({
      backdrop: 'static',
      keyboard: false
    });
  },
  remove_spinner: function() {
    clearTimeout(this.spinner);
    $('div#page-spinner').modal('hide');
    return $('div#page-spinner').on('hidden', function() {
      return $(this).remove();
    });
  }
};

$(document).on('page:fetch', function() {
  return PageSpinner.spin();
});

$(document).on('submit', 'form, input, button', function() {
    return PageSpinner.spin();
});
// spinner for nav links
// $(document).on('click', '.navbar li a, .sidebar li a', function() {
//     return PageSpinner.spin();
// });
