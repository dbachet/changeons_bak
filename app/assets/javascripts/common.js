$(document).ready(function() {
	// alert("hmm, elle est pas contente...");

	$('#back_to_top_button').click(
        function (event) {
			event.preventDefault();
            $('html, body').animate({scrollTop: '0px'}, 800);
        }
    );
	
	notice_alert_fields();
	
	$("#notice_alert_fields").live('change', function(event) {
		notice_alert_fields();
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
	
	// $('form#comment_new input, form#comment_new textarea, form#reply_new input, form#reply_new textarea').live({
	// mouseenter: function() {
	//   	$(this).animate({
	//     	opacity: 1// ,
	// 		// 			width: '75px',
	// 		// 			height: '75px'
	// 	}, 200);
	// },
	// mouseleave: function() {
	// 	$(this).animate({
	// 	  	opacity: 0.5// ,
	// 		// 			width: '50px',
	// 		// 			height: '50px'
	// 	}, 100);
	// }
	// });
	
	// END - form hover
	
	
	// $('article#post div#post_vote').live({
	// mouseenter: function() {
	//   	$('img', this).animate({
	//     	width: '36px',
	// 		height: '34px'
	// 	}, 0);
	// },
	// mouseleave: function() {
	// 	$('img', this).animate({
	// 	  	width: '30px',
	// 		height: '29px'
	// 	}, 0);
	// }
	// });
	

	// jQuery(function($){ 
	//   	$('ul#items_1').easyPaginate({
	// 		pause: 7000,
	// 		numeric: true,
	// 		controls: 'pagination_1',
	// 		clickstop: false
	// 	}),
	// 	$('ul#items_2').easyPaginate({
	// 		pause: 7000,
	// 		numeric: true,
	// 		controls: 'pagination_2',
	// 		clickstop: false
	// 	});
	//   });
	
	


// $('form#comment_new[data-validate]').validate();



});



function add_drawback_remove_links(link_to_remove_drawback){
	var li_classes = $('ul#drawbacks_preview li');
	if (li_classes.length) {
		li_classes.each(function(index) {
			$(this).before("<div class='drawback_icon'></div>");
		    $(this).append('<a href="' + link_to_remove_drawback + '?source=' + $(this).attr('class') + '" data-remote="true" class="remove_item"' + '>Supprimer</a>');
		});
	}
}

function notice_alert_fields() {
	var notice_alert_field = $("#notice_alert_fields"),
		notice_field_value = notice_alert_field.find("div.notice").html(),
		alert_field_value = notice_alert_field.find("div.alert").html(),
		top_page_height = $('nav#top_page').height(),
		top_categories_position = $('nav#top_categories ul').attr('class');
	
	// Check if top categories bar is displayed
	if (top_categories_position == "down") {
		var top = $('nav#top_categories ul').height() + $('nav#top_categories ul').position().top + top_page_height + 10;
	} else {
		var top = top_page_height + 13;
	}
	
	
	if ( notice_field_value != ""){
		
		notice_alert_field.delay(1000).animate({paddingTop: top}, 800, 'easeOutBounce');
		notice_alert_field.find("div.notice").delay(1000).fadeIn(500);
		notice_alert_field.find("div.notice").delay(9000).fadeOut();
		if ( alert_field_value != ""){
			
			notice_alert_field.find("div.alert").delay(1000).fadeIn(500);
			
			
			notice_alert_field.find("div.alert").delay(9000).fadeOut();
		}
		var var1 = (top - 13) + 'px',
			var2 = (top + 10) + 'px';
			
		notice_alert_field.delay(8000).animate({paddingTop: var1}, 70);
		notice_alert_field.delay(70).animate({paddingTop: var2}, 120);
		notice_alert_field.delay(120).animate({paddingTop: '0px', opacity: '0'}, 200);
	} else {
		if ( alert_field_value != ""){
			top = top - 10 + "px";
			notice_alert_field.delay(1000).animate({paddingTop: top}, 800, 'easeOutBounce');
			notice_alert_field.find("div.alert").delay(1000).fadeIn(500);
			notice_alert_field.find("div.alert").delay(9000).fadeOut();
			
			var var1 = (top - 13) + 'px',
				var2 = (top + 10) + 'px';

			notice_alert_field.delay(8000).animate({paddingTop: var1}, 70);
			notice_alert_field.delay(70).animate({paddingTop: var2}, 120);
			notice_alert_field.delay(120).animate({paddingTop: '0px', opacity: '0'}, 200);
		}
	}
	
	// if ( notice_field_value != ""){
	// 	notice_alert_field.find("div.notice").fadeIn("slow");
	// 	notice_alert_field.find("div.notice").animate({marginTop: top}, 200);
	// 	notice_alert_field.find("div.notice").delay(8000).fadeOut("slow");
	// 	if ( alert_field_value != ""){
	// 		notice_alert_field.find("div.alert").fadeIn("slow");
	// 		notice_alert_field.find("div.alert").animate({marginTop: "15px"}, 200);
	// 		notice_alert_field.find("div.alert").delay(8590).animate({marginTop: top}, 400);
	// 		notice_alert_field.find("div.alert").delay(4000).fadeOut("slow");
	// 	}
	// } 
	// 
	// if ( alert_field_value != ""){
	// 	notice_alert_field.find("div.alert").fadeIn("slow");
	// 	notice_alert_field.find("div.alert").animate({marginTop: top}, 200);
	// 	notice_alert_field.find("div.alert").delay(8000).fadeOut("slow");
	// }
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
