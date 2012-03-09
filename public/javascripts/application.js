// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// jQuery.ajaxSetup({
//   'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript") }
// });

$(document).ready(function() {
	$(function() {        
      $("#share").floatingFixed({ padding: 70 });
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

function add_advantage_links(link_to_remove_advantage){
	var li_classes = $('ul#advantages_preview li');
	if (li_classes.length) {
		li_classes.each(function(index) {
		    $(this).append('<a href="' + link_to_remove_advantage + '?source=' + $(this).attr('class') + '" data-remote="true" class="remove_source"' + '>Supprimer</a>');
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
