$(document).ready(function() {
	add_remove_source_links();
	
	bind_add_source();
	
	bind_remove_sources();
	
});






function remove_source(source) {
	$('ul#sources_display li.' + source).remove();
	$('ul#sources_display li a.remove_source').remove();

	var sources_val = $('ul#sources_display').html();
	$('textarea#sources_input').val(sources_val);

	add_remove_source_links();
	
	bind_remove_sources();
}

function add_source() {
	var source_description_val = $('input#source_description_input').val(),
	source_val = $('input#html_link_input').val(),
	sources_val = $('ul#sources_display').html(),
	last_source = $('ul#sources_display li:last-child');
	
	
	
	if (last_source.length){
		last_source = parseInt(last_source.attr('class'));
		last_source++;
	} else{
		last_source = "0";
	}
	
	
	if (source_val != "http://" && source_val != ""){
		
		if (source_description_val == ""){
			source_description_val = "Lien";
		}
		
		if (sources_val == "") {
			sources_val = "<li class='" + last_source + "'>" + "<a href=" + source_val + " target='_blank' >" + source_description_val + "</a>" + "<a href='' data-remote='true' class='remove_source'>Supprimer</a></li>";
		} else {
			sources_val = sources_val + "<li class='" + last_source + "'>" + "<a href=" + source_val + " target='_blank' >" + source_description_val + "</a>" + "<a href='' data-remote='true' class='remove_source'>Supprimer</a></li>";
		}
		
		copy_to_textarea(sources_val);
		
	} else if (source_description_val != ""){
		if (sources_val == "") {
			sources_val = "<li class='" + last_source + "'>" + source_description_val + "<a href='' data-remote='true' class='remove_source'>Supprimer</a></li>";
		} else {
			sources_val = sources_val + "<li class='" + last_source + "'>" + source_description_val + "<a href='' data-remote='true' class='remove_source'>Supprimer</a></li>";
		}
		
		copy_to_textarea(sources_val);
	}
		
	
	$('input#html_link_input').val("http:\/\/");
	$('input#source_description_input').val("");
	bind_remove_sources();
}

function bind_add_source() {
	$('#add_source').click(function(event){
		event.preventDefault();
		add_source();
	});
}

function bind_remove_sources(){
	$('.remove_source').click(function(event){
		event.preventDefault();
		// alert("remove_source");
		source = $(this).closest('li').attr('class');
		// alert(source);
		remove_source(source);
	});
}

function add_remove_source_links(){
	var li_classes = $('ul#sources_display li');
	if (li_classes.length) {
		li_classes.each(function(index) {
		    $(this).append('<a href="" data-remote="true" class="remove_source"' + '>Supprimer</a>');
		});
	}
}
	
function copy_to_textarea(sources_val){
	$('ul#sources_display').html(sources_val);
	$('ul#sources_display li a.remove_source').remove();
	var sources_val_without_remove_link = $('ul#sources_display').html();
	$('textarea#sources_input').val(sources_val_without_remove_link);
	$('ul#sources_display').html(sources_val);
}