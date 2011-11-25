// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
	
	// Fancyboxes
	$('a.fancybox_signin').fancybox({
		closeClick: false,
		afterLoad:	function() {
			$('form#user_new[data-validate]').validate();
		},
		afterClose: function() {
			$('form#new_reply[data-validate], form#new_comment[data-validate]').validate();
		}
	});
	
	$('a.new_category_link').fancybox({
		closeClick: false,
		afterLoad:	function() {
			$('form#new_category[data-validate]').validate();
		}
	});
	
	$('a.new_post_type_link').fancybox({
		closeClick: false,
		afterLoad:	function() {
			$('form#new_post_type[data-validate]').validate();
		}
	});
	
	$('a.index_categories_link, a.index_post_types_link').fancybox({
		closeClick: false
	});
	
	// End fancyboxes

var post_id = $('form#new_comment input#comment_title').data('post-id');
if (post_id){
	$('a.fancybox_signin').attr('href', '/sessions/fancy_login?post_id=' + post_id);
} else {
	$('a.fancybox_signin').attr('href', '/sessions/fancy_login');
}

$('form#new_comment[data-validate]').validate();
$('form#new_reply[data-validate]').validate();
});
