$(document).ready(function(){
	$('#account_links .tooltipped').tipsy({fade:true, live:true, offset: 18});
	$('#back_to_top_button.tooltipped').tipsy({fade:true, live:true, offset: 8});
	$('#display_categories_button.tooltipped').tipsy({fade:true, live:true, offset: -10});
	$('#breadcrumbs a').tipsy({fade:true, live:true, offset: 0});
	$('article.form textarea').tipsy({trigger: 'focus', gravity: 'e'});
	$('article.form input[type="text"]').tipsy({trigger: 'focus', gravity: 'w'});
	$('article.form select').tipsy({trigger: 'focus', gravity: 'w'});
});