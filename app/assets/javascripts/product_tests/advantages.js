$(document).ready(function() {
	add_remove_advantage_links();
	bind_add_advantage();
	
	// bind_remove_sources();
	
});

function add_advantage() {
	var advantage_val = $('input#product_test_advantage').val(),
		advantages_val = $('ul#advantages_preview').html(),
		last_advantage = $('ul#advantages_preview li:last-child');

		if (last_advantage.length){
			last_advantage = parseInt(last_advantage.attr('class'));
			last_advantage++;
		} else{
			last_advantage = "0";
		}

		// var link_to_remove_advantage = "<%= product_tests_remove_advantage_path %>";


		if (advantage_val != ""){

			if (advantages_val != "") {
				// alert("if");
				advantages_val = advantages_val + "<li class='" + last_advantage + "'><span class='advantage_icon'></span><span class='advantage'>" + advantage_val + "</span></a>" + "<a href='' data-remote='true' class='remove_advantage'>Supprimer</a></li>";
			} else {
				// alert(advantages_val);
				advantages_val = "<div class='advantage_icon'></div><li class='" + last_advantage + "'><span class='advantage_icon'></span><span class='advantage'>" + advantage_val + "</span></a>" + "<a href='' data-remote='true' class='remove_advantage'>Supprimer</a></li>";
			}

			$('ul#advantages_preview').html(advantages_val);
			$('ul#advantages_preview li a.remove_advantage').remove();
			$('ul#advantages_preview li span.advantage_icon').remove();
			var advantages_val_without_remove_link = $('ul#advantages_preview').html();
			$('#product_test_advantages').val(advantages_val_without_remove_link);
			$('ul#advantages_preview').html(advantages_val);
		}


	// $('a#add_advantage_button').remove();
	$('input#product_test_advantage').val("");
	bind_remove_advantage();
	// $('div#advantage_buttons').html('<%= escape_javascript(link_to("Ajouter un avantage", product_tests_show_advantage_form_field_path, :remote => true, :id => "show_advantage_form_field_button")) %>');
}

function remove_advantage(advantage) {
	$('ul#advantages_preview li.' + advantage).remove();
	
	// We remove all the icons and remove advantage links
	$('ul#advantages_preview li span.advantage_icon').remove();
	$('ul#advantages_preview li a.remove_advantage').remove();
	
	var advantages_val = $('ul#advantages_preview').html();
	
	
	$('#product_test_advantages').val(advantages_val);
	
	
	// We had again the icons and remove advantage links
	add_remove_advantage_links();
	
}

function bind_add_advantage() {
	$('#add_advantage_button').click(function(event){
		event.preventDefault();
		add_advantage();
	});
}

function bind_remove_advantage() {
	$('.remove_advantage').click(function(event){
		event.preventDefault();
		advantage = $(this).closest('li').attr('class');
		remove_advantage(advantage);
	});
}



function add_remove_advantage_links(){
	var li_classes = $('ul#advantages_preview li');
	if (li_classes.length) {
		li_classes.each(function(index) {
			$(this).find('span.advantage').before("<span class='advantage_icon'></span>");
		    $(this).find('span.advantage').after('<a href="" data-remote="true" class="remove_advantage"' + '>Supprimer</a>');
		});
	}
	
	bind_remove_advantage();
}

// add_advantage_remove_links("<%= product_tests_remove_advantage_path %>");
// add_drawback_remove_links("<%= product_tests_remove_drawback_path %>");