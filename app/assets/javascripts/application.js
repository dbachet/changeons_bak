// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require fancybox
//= require ckeditor/init
//= rails.validations
//= jquery-ui-1.8.17.custom.min
//= jquery.ui.datepicker-fr
//= jquery.floatingFixed
//= jquery.cookies.2.2.0.min
//= require_self




$(document).ready(function() {
	// alert("hmm, elle est pas contente...");
	
	$(function() {        
		
	var topPageHeight = $('nav#top_page').height() + 40;
      $("#share").floatingFixed({ padding: topPageHeight });
    });

	$('#back_to_top_button').click(
        function (event) {
			event.preventDefault();
            $('html, body').animate({scrollTop: '0px'}, 800);
        }
    );
	
	var resizeTimer = null;
	$(window).bind(
	'load', function() {
		if (resizeTimer) clearTimeout(resizeTimer); 
		    resizeTimer = setTimeout(configTop, 100);
	});
	
	$(window).bind(
	'resize', function() {
	  	if (resizeTimer) clearTimeout(resizeTimer); 
		    resizeTimer = setTimeout(configTop, 100);
	});
	
	// $.event.add(window, "load", configTop);
	// $.event.add(window, "resize", configTop);
	
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
	
	$('.fancybox_signin').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form#user_new[data-validate]').validate();
			
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
	$('section#posts article, section#tips article,	section#events article,	section#product_tests article, section#questions article').live({
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
			pause: 7000,
			numeric: true,
			controls: 'pagination_1',
			clickstop: false
		}),
		$('ul#items_2').easyPaginate({
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

function add_advantage_remove_links(link_to_remove_advantage){
	var li_classes = $('ul#advantages_preview li');
	if (li_classes.length) {
		li_classes.each(function(index) {
			$(this).before("<div class='advantage_icon'></div>");
		    $(this).append('<a href="' + link_to_remove_advantage + '?source=' + $(this).attr('class') + '" data-remote="true" class="remove_item"' + '>Supprimer</a>');
		});
	}
}

function add_drawback_remove_links(link_to_remove_drawback){
	var li_classes = $('ul#drawbacks_preview li');
	if (li_classes.length) {
		li_classes.each(function(index) {
			$(this).before("<div class='drawback_icon'></div>");
		    $(this).append('<a href="' + link_to_remove_drawback + '?source=' + $(this).attr('class') + '" data-remote="true" class="remove_item"' + '>Supprimer</a>');
		});
	}
}
	

function configTop() {
    var topPageHeight = $('nav#top_page').height(),
		widthListItems = 0,
		topCategoriesUl = $('nav#top_categories > ul'),
		topCategoriesLi = $('nav#top_categories > ul > li'),
		windowWidth = $(window).width(),
		maxWidth = 1200,
		navCategories = $('nav#top_categories'),
		paddingUl = topCategoriesUl.css('padding');

	// Set the margin-top of the menu to be able to see categories
	navCategories.css('margin-top', topPageHeight);
	
	// Set the width of the ul menu to fit in the window
	topCategoriesLi.each(function(index) {
		widthListItems += $(this).width() + 24;
	});
	
	if (navCategories.width() - 20 <= widthListItems){
		widthListItems = navCategories.width();
		// alert("hoooo");
	}
	
	if (maxWidth - (paddingUl*2) - 20 <= widthListItems){
		widthListItems = maxWidth - 20;
		// alert("hoooo");
	}
	
	topCategoriesUl.animate({
    	width: widthListItems,
	}, 400);
	
}

function read_stored_form_details_for_comments() {
	commentTitleCookie = $.cookies.get('commentTitle');
	commentBodyCookie = $.cookies.get('commentBody');
	replyTitleCookie = $.cookies.get('replyTitle');
	replyBodyCookie = $.cookies.get('replyBody');
	replyParentIdCookie = $.cookies.get('replyParentId');
	scrollPosition = $.cookies.get('scrollPosition');
	
	if (commentTitleCookie){
		$('#comment_title').val(commentTitleCookie);
		$.cookies.del('commentTitle', {path: location.pathname});
	}
	
	if (commentBodyCookie){
		$('#comment_body').val(commentBodyCookie);
		$.cookies.del('commentBody', {path: location.pathname});
	}
	
	if (replyParentIdCookie){
		$.cookies.del('replyParentId', {path: location.pathname});
		
		
		

		$('div.wrap_form_new_reply').hide();

		$('div.wrap_form_new_reply').fadeIn("slow");


		$('form#reply_new[data-validate], form#comment_new[data-validate]').validate();
		
		if (replyTitleCookie){
			$('#reply_title').val(replyTitleCookie);
			$.cookies.del('replyTitle', {path: location.pathname});
		}
	
		if (replyBodyCookie){
			$('#reply_body').val(replyBodyCookie);
			$.cookies.del('replyBody', {path: location.pathname});
		}
	}
	
	
	
	if (scrollPosition){
		$.cookies.del('scrollPosition', {path: location.pathname});
		$('html, body').scrollTop(scrollPosition);
		var mem_color = $('#wrap_form_new_comment').css("background-color");
		var mem_color2 = $('.wrap_form_new_reply').css("background-color");
		$('#wrap_form_new_comment').delay(1200).animate({backgroundColor: 'pink'}, 300);
		$('.wrap_form_new_reply').delay(1200).animate({backgroundColor: 'pink'}, 300);
		$('#wrap_form_new_comment').animate({backgroundColor: mem_color}, 2800);
		$('.wrap_form_new_reply').animate({backgroundColor: mem_color2}, 2800);
		
	}
}

function bind_delete_presentation_picture_link() {
	$('#delete_presentation_picture_link').click(function(event){
		event.preventDefault();
		$.ajax({
	        url: '/presentation_picture',  //server script to process data
	        type: 'DELETE',
	        //Ajax events
	        // beforeSend: beforeSendHandler,
	        // 		        success: completeHandler,
	        // 		        error: errorHandler,
	        // Form data
	        // data: formData,
	        //Options to tell JQuery not to process data or worry about content-type
	        cache: false,
	        contentType: false,
	        processData: false
	    });
	});
}
