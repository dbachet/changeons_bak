$(document).ready(function() {
	add_remove_drawback_links();
	bind_add_drawback();
	
	// bind_remove_sources();
	
});

function add_drawback() {
	var drawback_val = $('input#product_test_drawback').val(),
		drawbacks_val = $('ul#drawbacks_preview').html(),
		last_drawback = $('ul#drawbacks_preview li:last-child');

		if (last_drawback.length){
			last_drawback = parseInt(last_drawback.attr('class'));
			last_drawback++;
		} else{
			last_drawback = "0";
		}

		// var link_to_remove_drawback = "<%= product_tests_remove_advantage_path %>";


		if (drawback_val != ""){

			if (drawbacks_val != "") {
				// alert("if");
				drawbacks_val = drawbacks_val + "<li class='" + last_drawback + "'><span class='drawback_icon'></span><span class='drawback'>" + drawback_val + "</span></a>" + "<a href='' data-remote='true' class='remove_drawback'>Supprimer</a></li>";
			} else {
				// alert(advantages_val);
				drawbacks_val = "<div class='drawback_icon'></div><li class='" + last_drawback + "'><span class='drawback_icon'></span><span class='drawback'>" + drawback_val + "</span></a>" + "<a href='' data-remote='true' class='remove_drawback'>Supprimer</a></li>";
			}

			$('ul#drawbacks_preview').html(drawbacks_val);
			$('ul#drawbacks_preview li a.remove_drawback').remove();
			$('ul#drawbacks_preview li span.drawback_icon').remove();
			var drawbacks_val_without_remove_link = $('ul#drawbacks_preview').html();
			$('#product_test_drawbacks').val(drawbacks_val_without_remove_link);
			$('ul#drawbacks_preview').html(drawbacks_val);
		}


	// $('a#add_advantage_button').remove();
	$('input#product_test_drawback').val("");
	bind_remove_drawback();
	// $('div#advantage_buttons').html('<%= escape_javascript(link_to("Ajouter un avantage", product_tests_show_advantage_form_field_path, :remote => true, :id => "show_advantage_form_field_button")) %>');
}

function remove_drawback(drawback) {
	$('ul#drawbacks_preview li.' + drawback).remove();
	
	// We remove all the icons and remove drawback links
	$('ul#drawbacks_preview li span.drawback_icon').remove();
	$('ul#drawbacks_preview li a.remove_drawback').remove();
	
	var drawbacks_val = $('ul#drawbacks_preview').html();
	
	
	$('#product_test_drawbacks').val(drawbacks_val);
	
	
	// We had again the icons and remove drawback links
	add_remove_drawback_links();
	
}

function bind_add_drawback() {
	$('#add_drawback_button').click(function(event){
		event.preventDefault();
		add_drawback();
	});
}

function bind_remove_drawback() {
	$('.remove_drawback').click(function(event){
		event.preventDefault();
		drawback = $(this).closest('li').attr('class');
		remove_drawback(drawback);
	});
}



function add_remove_drawback_links(){
	var li_classes = $('ul#drawbacks_preview li');
	if (li_classes.length) {
		li_classes.each(function(index) {
			$(this).find('span.drawback').before("<span class='drawback_icon'></span>");
		    $(this).find('span.drawback').after('<a href="" data-remote="true" class="remove_drawback"' + '>Supprimer</a>');
		});
	}
	
	bind_remove_drawback();
}

// add_advantage_remove_links("<%= product_tests_remove_advantage_path %>");
// add_drawback_remove_links("<%= product_tests_remove_drawback_path %>");