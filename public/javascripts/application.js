// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
	
	$('a.fancybox_signin').fancybox({
	    'hideOnContentClick': false,
		'onComplete':	function() {
			$('form#user_new[data-validate]').validate();
		},
		'onClosed': function() {
			$('form#new_reply[data-validate], form#new_comment[data-validate]').validate();
		}
	});

var post_id = $('form#new_comment input#comment_title').data('post-id');
$('a.fancybox_signin').attr('href', '/sessions/fancy_login?post_id=' + post_id);

$('form#new_comment[data-validate]').validate();
$('form#new_reply[data-validate]').validate();
});
