$(document).ready(function() {
	add_advantage_icons();
	add_drawback_icons();	
});

function add_advantage_icons(){
	var li_classes = $('ul#advantages_preview li');
	if (li_classes.length) {
		li_classes.each(function(index) {
			$(this).find('span.advantage').before("<span class='advantage_icon'></span>");
		});
	}
}

function add_drawback_icons(){
	var li_classes = $('ul#drawbacks_preview li');
	if (li_classes.length) {
		li_classes.each(function(index) {
			$(this).find('span.drawback').before("<span class='drawback_icon'></span>");
		});
	}
}