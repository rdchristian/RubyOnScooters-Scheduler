/* 
* @Author: Synix
* @Date:   2015-05-02 22:03:44
* @Last Modified by:   Synix
* @Last Modified time: 2015-05-04 02:46:27
*/

'use strict';

$.pjax.defaults.timeout = 3000;

function getAction() { return $('.pjax-nav-content #active-pane').val(); }
function updateTabs($el) {
  if(!$el) return;
  $('ul.nav-tabs li.active').removeClass('active').find('a').css('background-color', 'inherit');
  $el.parent('li').addClass('active').find('a').css('background-color', '#EEE');
}

function updateNav(click) {
  // Figure out which nav to update, if click is supplied, also run the ajax
  if(click)
    $(getAction()).trigger('click');
  else
    updateTabs($(getAction()));
}

function cleanUp(e) {
  debugger;
  if($(e.target).hasClass('pjax-results')) return;
  $("*[class^='selectable-']").each(function() {
    if ($(this)[0].selectize) {
      $(this)[0].selectize.destroy();
    }
  });
}

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
  return;
}

function search_facilities() {
  return;
}
// document.ready
$(function() {

  // Configuring pjax
  $(document).pjax('.nav a', '.pjax-nav-content');
  $(document).pjax('#BANG', '.pjax-results');
  setTimeout(function() { updateNav(true); }, 1); // Somehow it works only in a timeout block

  // $(document).pjax(getAction() + '_submit', '.pjax-results', { url: getAction() + '?' + $(this).serialize() });
  // $(getAction() + '_form').submit(function(e) {
  //   e.preventDefault();
  //   $.pjax({ container: '.pjax-results', url: getAction() + '?' + $(this).serialize() });
  // });

  // $(document).on('submit', getAction() + '_form', function(event) {
  //   $.pjax.submit(event, '.pjax-results');
  // });
  $('.nav-tabs a').click(function(e) {
    // Don't send a request if element is disabled
    if($(this).parent().hasClass('disabled'))
    {
      e.stopPropagation();
      return false;
    }
    updateTabs($(this));
  })

  // Clean up jQuery elements that don't clean themselves up before caching the page
  // so that we can reinitialize them when using browser back/forward
  $(document).on('pjax:beforeSend', cleanUp);
  $(document).on('pjax:popstate', cleanUp);

  $(document).on('pjax:start', function(e) {
    debugger;
    if($(e.target).hasClass('pjax-results')) return;
    var height = $('.tab-pane').outerHeight();
    $('.tab-pane').fadeOut(300, function() {
      // Don't collapse the element's space after fading out but still keep it hidden
      $(this).parent().css('min-height', height);
    });
    // Prevent multiple requests
    $('.nav-tabs li').addClass('disabled');
  }); 

  $(document).on('pjax:end', function(e) {
    debugger;
    if($(e.target).hasClass('pjax-results')) return;
    // So it works with browser back/forward buttons too
    updateNav();
    // Promise waits for all animations to finish
    $('.tab-pane').promise().done(function() {
      // I'm using pjax-nav-content as a staging area to hold the tab-pane's content before fadeIn happens.
      $(this).html($('.pjax-nav-content').html());

      // Fade in and correct the height
      $(this).fadeIn(500).parent().css('min-height', $(this).outerHeight());    
      $('.nav-tabs li').removeClass('disabled');

      // Call nav specific js
      window[getAction().substr(1)]();
    });
  });

});