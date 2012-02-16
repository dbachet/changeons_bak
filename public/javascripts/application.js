// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// jQuery.ajaxSetup({
//   'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript") }
// });

$(document).ready(function() {
	
	$(function() {
			$( ".datepicker" ).datepicker();
		});
	
	/** 
	 * Character Counter for inputs and text areas 
	 */  
	$('.char_count').each(function(){  
	    // get current number of characters  
	    var length = $(this).val().length;  
	    // get current number of words  
	    //var length = $(this).val().split(/\b[\s,\.-:;]*/).length;  
	    // update characters  
	    $(this).parent().find('.counter').html( length + ' caractères');  
	    // bind on key up event  
	    $(this).keyup(function(){  
	        // get new length of characters  
	        var new_length = $(this).val().length;  
	        // get new length of words  
	        //var new_length = $(this).val().split(/\b[\s,\.-:;]*/).length;  
	        // update  
	        $(this).parent().find('.counter').html( new_length + ' caractères');  
	    });  
	});
	
	
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
	$('section#posts article, section#tips article,	section#events article,	section#product_tests article, section#changeons_home article').live({
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
	
	$('form#comment_new input, form#comment_new textarea, form#reply_new input, form#reply_new textarea').live({
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


function add_source_links(link_to_remove_source){
	var li_classes = $('ul#sources_display li');
	if (li_classes.length) {
		li_classes.each(function(index) {
		    $(this).append('<a href="' + link_to_remove_source + '?source=' + $(this).attr('class') + '" data-remote="true" class="remove_source"' + '>Supprimer</a>');
		});
	}
}
