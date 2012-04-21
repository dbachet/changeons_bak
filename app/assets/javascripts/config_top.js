$(document).ready(function(){
	$('#display_categories_button').click(function(event){
		event.preventDefault();
		// alert("rfer");
		var showOrHide = $(this).data('show'),
			list_categories = $('nav#top_categories').find('ul');
		
		
		if (showOrHide){
			$(this).find('.top_categories_arrows').css("background-position", "0 0");
			$(this).attr('title', 'Afficher les catégories');
			list_categories.animate({marginTop: '-13px'}, 70);
			list_categories.animate({marginTop: '-3px'}, 120);
			list_categories.animate({marginTop: '-45px', opacity: '0'}, 200);
			
			$(this).data('show', false);
			list_categories.hide(10);
		} else{
			$(this).find('.top_categories_arrows').css("background-position", "0 -15px");
			$(this).attr('title', 'Retirer la liste des catégories');
			list_categories.show();
			list_categories.css("opacity", '1');
			// list_categories.animate({marginTop: '-20px'}, 140);
			// list_categories.animate({marginTop: '-10px'}, 80);
			// list_categories.animate({marginTop: '-15px'}, 60);
			// list_categories.animate({marginTop: '-17px'}, 50);
			// list_categories.animate({marginTop: '-19px'}, 70);
			list_categories.animate({marginTop: '-10px', opacity: '1'}, 700, 'easeOutBounce');
			
			
			$(this).data('show', true);
		}
	});
	// $('nav#top_categories').delay(5000).slideUp(3000);
	// alert();
	// var resizeTimer = null;
	// $(window).bind(
	// 'load', function() {
	// 	if (resizeTimer) clearTimeout(resizeTimer); 
	// 	    resizeTimer = setTimeout(configTop, 100);
	// });
	// 
	// $(window).bind(
	// 'resize', function() {
	//   	if (resizeTimer) clearTimeout(resizeTimer); 
	// 	    resizeTimer = setTimeout(configTop, 100);
	// });
});


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