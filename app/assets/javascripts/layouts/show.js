$(document).ready(function() {
	var topPageHeight = $('nav#top_page').height() + 40;
	$("#share").floatingFixed({ padding: topPageHeight });

	$('#refuse_link').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form.moderation_setting[data-validate]').validate();
		}
	});
	
	$('.comment_refuse_link').fancybox({
		closeClick: false,
		afterShow:	function() {
			$('form.moderation_setting[data-validate]').validate();
		}
	});
	
	
});