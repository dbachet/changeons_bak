// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// jQuery.ajaxSetup({
//   'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript") }
// });

$(document).ready(function() {

	
	
	// Fancyboxes
	$('a.fancybox_signin').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form#user_new[data-validate]').validate();
		},
		afterClose: function() {
			$('form#new_reply[data-validate], form#new_comment[data-validate]').validate();
		}
	});
	
	$('a.new_category_link').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form#new_category[data-validate]').validate()
		}
	});
	
	$('a.edit_category_link').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form.edit_category[data-validate]').validate()
		}
	});
	
	$('a.new_post_type_link').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form#new_post_type[data-validate]').validate();
		}
	});
	
	$('a.edit_post_type_link').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form.edit_post_type[data-validate]').validate();
		}
	});
	
	$('a.index_categories_link, a.index_post_types_link').fancybox({
		closeClick: false
	});
	
	// End fancyboxes


$('form#new_comment[data-validate]').validate();
$('form#new_reply[data-validate]').validate();


});



