// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// jQuery.ajaxSetup({
//   'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript") }
// });

$(document).ready(function() {

	
	
	// Fancyboxes
	// $('a.fancybox_signin').fancybox({
	// 	closeClick: false,
	// 	afterShow:	function() {
	// 		$('form#user_new[data-validate]').validate();
	// 	},
	// 	afterClose: function() {
	// 		$('form#reply_new[data-validate], form#comment_new[data-validate]').validate();
	// 	}
	// });
	
	
	$('a.admin_new_user_registration_link').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form#user_new[data-validate]').validate()
		}
	});
	
	$('a.admin_edit_user_registration_link').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form#user_edit[data-validate]').validate()
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
	
	$('a.index_categories_link, a.index_post_types_link, a.admin_users_link, a.index_newsletter_subscribers_link').fancybox({
		closeClick: false
	});
	
	$('a.edit_comment_link').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form#comment_edit[data-validate]').validate()
		}
	});
	// End fancyboxes

	// post list for home page
	$('section#posts_home article').live({
	mouseenter: function() {
	  	$('img', this).animate({
	    	opacity: 1,
			marginLeft: '-30px'// ,
			// 			width: '75px',
			// 			height: '75px'
		}, 200);
	},
	mouseleave: function() {
		$('img', this).animate({
		  	opacity: 0.5,
			marginLeft: '0px'// ,
			// 			width: '50px',
			// 			height: '50px'
		}, 100);
	}
	});
	// END - post list for home page
	
	// form hover
	
	$('form#comment_new input, form#comment_new textarea, form#reply_new input, form#reply_new textarea, input#newsletter_subscriber_email').live({
	mouseenter: function() {
	  	$(this).animate({
	    	opacity: 1// ,
			// 			width: '75px',
			// 			height: '75px'
		}, 200);
	},
	mouseleave: function() {
		$(this).animate({
		  	opacity: 0.5// ,
			// 			width: '50px',
			// 			height: '50px'
		}, 100);
	}
	});
	
	// END - form hover
	
	
	$('article#post div#post_vote').live({
	mouseenter: function() {
	  	$('img', this).animate({
	    	width: '36px',
			height: '34px'
		}, 0);
	},
	mouseleave: function() {
		$('img', this).animate({
		  	width: '30px',
			height: '29px'
		}, 0);
	}
	});
	

	jQuery(function($){ 
	  	$('ul#items_1').easyPaginate({
			auto: true,
			pause: 7000,
			numeric: true,
			controls: 'pagination_1',
			clickstop: false
		}),
		$('ul#items_2').easyPaginate({
			auto: true,
			pause: 7000,
			numeric: true,
			controls: 'pagination_2',
			clickstop: false
		});
	  });
	
	


$('form#comment_new[data-validate]').validate();
$('form#reply_new[data-validate]').validate();


});



