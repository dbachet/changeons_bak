$(document).ready(function() {
	init_fancyboxes();
});

function init_fancyboxes() {
	$('.fancybox_signin').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form#new_user[data-validate]').validate();
		
			var commentTitleInput = $('#comment_title'), 
				commentBodyInput = $('#comment_body'),
				replyTitleInput = $('#reply_title'),
				replyBodyInput = $('#reply_body'),
				scrollPosition = $(window).scrollTop();
			
			if (commentTitleInput[0]){
				$('#user_stored_comment_title').val(commentTitleInput.val());
				$('#user_stored_comment_body').val(commentBodyInput.val());
			}
		
			// alert(replyTitleInput.val());
		
			if (replyTitleInput[0]){
				var replyParent = replyTitleInput.closest('.root_comment_area').attr('class');
				var replyParentId = replyParent.match(/\d+(,\d+)?/)[0];
				$('#user_stored_reply_title').val(replyTitleInput.val());
				$('#user_stored_reply_body').val(replyBodyInput.val());
				$('#user_reply_parent_id').val(replyParentId);
			}
		
			if (commentTitleInput[0] || replyTitleInput[0]){
				$('#user_scroll_position').val(scrollPosition);
			}
		
			// $.cookies.setOptions({path: location.pathname, hoursToLive: 0.05});
			// 			
			// 			var commentTitleInput = $('#comment_title');
			// 			var commentBodyInput = $('#comment_body');
					
			// if (commentTitleInput[0]){
				// $('#comment_title').cookify();
				// $('#comment_body').cookify();
			
				// $.cookies.set('commentTitle', commentTitleInput.val());
				// $.cookies.set('commentBody', commentBodyInput.val());
			// }
		}
	});

	$('a.presentation_picture_link').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form#new_presentation_picture[data-validate]').validate();
		}
	});

	$('a.admin_new_user_registration_link').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form#new_user[data-validate]').validate()
		}
	});

	// 
	$('a.admin_edit_user_registration_link').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form#edit_user[data-validate]').validate()
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

	$('a.edit_newsletter_subscribers_link').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form.newsletter_subscriber[data-validate]').validate();
		}
	});

	$('a.admin_users_link').fancybox({
		closeClick: false
	});

	$('a.index_categories_link, a.index_post_types_link, a.index_newsletter_subscribers_link').fancybox({
		closeClick: false
	});

	$('a.edit_comment_link').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form#comment_edit[data-validate]').validate()
		}
	});
	// End fancyboxes
}