/* 
* @Author: Synix
* @Date:   2015-05-02 22:03:44
* @Last Modified by:   Synix
* @Last Modified time: 2015-05-04 17:17:51
*/

'use strict';


function getAction() { return $('#active-pane').val(); }
// function updateTabs($el) {
//   if(!$el) return;
//   $('ul.nav-tabs li.active').removeClass('active').find('a').css('background-color', 'inherit');
//   $el.parent('li').addClass('active').find('a').css('background-color', '#EEE');
// }

// function updateNav(click) {
//   // Figure out which nav to update, if click is supplied, also run the ajax
//   if(click)
//     $(getAction()).trigger('click');
//   else
//     updateTabs($(getAction()));
// }

// function cleanUp() {
//   $("*[class^='selectable-']").each(function() {
//     if ($(this)[0].selectize) {
//       $(this)[0].selectize.destroy();
//     }
//   });
// }

function search_events() {
  // Configure daterange picker
  $('.range-datepicker').daterangepicker({
    showDropdowns: true,
    format: 'MMMM D, YYYY',
  });
  // Forward the click on the tiny calendar icon to the date picker
  $('.click-date').click(function(e) {
    $(this).siblings('.range-datepicker').click();
  });

  // Configure facility/resource selections
  var selectable_options = {
    persist: false,
    createOnBlur: true,
    create: false,
    highlight: true,
    maxOptions: 179, // Why 179? Fu, that's why
    sortField: { field: 'text', direction: 'asc' },
  };
  $('.selectable-facility').selectize(selectable_options);
  $('.selectable-resources').selectize(selectable_options);
}

function search_resources() {
  $(".number-picker").TouchSpin({
    max: 1000,
    min: 1,
    verticalbuttons: true,
    verticalupclass: 'glyphicon glyphicon-chevron-up',
    verticaldownclass: 'glyphicon glyphicon-chevron-down',
  });

  $('.clockpicker-disabled-ampm').clockpicker({
    placement: 'bottom',
    align: 'top',
    type: 'text',
    autoclose: 'true',
  });

  // datepicker already configured in events
}

function search_facilities() {
  return;
}

// document.ready
$(function() {
  search_events(); search_facilities(); search_resources();

  $('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
    $(e.target).css('background-color', '#EEE');           // newly activated tab
    $(e.relatedTarget).css('background-color', 'inherit'); // previous tab

    // Save the active tab in browser history so we can go back to it with the browser back button
    var action = $(e.target).attr('id');
    var url = '/' + action.replace('_','/');
    // Don't delete the query string if a tab change isn't happening
    if($(e.target).attr('id') == action)
      url += window.location.search;
    history.pushState(action, null, url);
  });
  $(getAction()).trigger('click').css('background-color', '#EEE');

  $(window).bind("popstate", function () {
    // Reload the search query and the page's javascript when using the browser's back/forward
    window.location.reload();
  });
  // $('#products th a, #products .pagination a').live('click', function() {
  //   $.getScript(this.href);
  //   history.pushState(null, document.title, this.href);
  //   return false;
  // });
  
  // $('#products_search input').keyup(function () {
  //   var action = $('#products_search').attr('action');
  //   var formData = $('#products_search').serialize();
  //   $.get(action, formData, null, 'script');
  //   history.replaceState(null, document.title, action + "?" + formData);
  //   return false;
  // });
  
  // $(window).bind("popstate", function () {
  //   $.getScript(location.href);
  // });

  // $(document).on('pjax:start', function(e) {
  //   debugger;
  //   if($(e.target).hasClass('pjax-results')) return;
  //   var height = $('.tab-pane').outerHeight();
  //   $('.tab-pane').fadeOut(300, function() {
  //     // Don't collapse the element's space after fading out but still keep it hidden
  //     $(this).parent().css('min-height', height);
  //   });
  //   // Prevent multiple requests
  //   $('.nav-tabs li').addClass('disabled');
  // }); 

  // $(document).on('pjax:end', function(e) {
  //   debugger;
  //   if($(e.target).hasClass('pjax-results')) return;
  //   // So it works with browser back/forward buttons too
  //   updateNav();
  //   // Promise waits for all animations to finish
  //   $('.tab-pane').promise().done(function() {
  //     // I'm using pjax-nav-content as a staging area to hold the tab-pane's content before fadeIn happens.
  //     $(this).html($('.pjax-nav-content').html());

  //     // Fade in and correct the height
  //     $(this).fadeIn(500).parent().css('min-height', $(this).outerHeight());    
  //     $('.nav-tabs li').removeClass('disabled');

  //     // Call nav specific js
  //     window[getAction().substr(1)]();
  //   });
  // });

});