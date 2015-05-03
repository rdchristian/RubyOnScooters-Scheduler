/* 
* @Author: Synix
* @Date:   2015-05-02 22:03:44
* @Last Modified by:   Synix
* @Last Modified time: 2015-05-03 01:06:27
*/

'use strict';

// $('#search_link').on('click', 'a',
//   function () {
//     history.pushState(null, "", this.href);
//     return true;
//   });

// $(function () {
//   $(window).bind("popstate", function () {
//     $.getScript(location.href);
//     return false;
//   });
// })

$(function() {

	var ajax_link = '#search_link a';
	var main_url = $(ajax_link).attr('href');
	// Configuring pjax
  $(document).pjax(ajax_link, '.pjax-container')


  // It adds tab href to url + opens tab based on hash on page load:
  var hash = window.location.hash;
  hash && $('ul.nav a[href="' + hash + '"]').tab('show');

  $('.nav-tabs a').click(function (e) {
    $(this).tab('show');
    var scrollmem = $('body').scrollTop();
    window.location.hash = this.hash;
    $(ajax_link).attr('href', main_url + this.hash);
    $('html,body').scrollTop(scrollmem);
  });


});