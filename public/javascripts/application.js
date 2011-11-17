// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {

  /* Using custom settings */
  // $('a[href$=/users/sign_in]').fancybox({
  //   'hideOnContentClick': false
  // });
	// $("a.show_reply_fields").click(function(event){
	// 	event.preventDefault();
	// });
	
	$('a.fancybox_signin').fancybox({
	    'hideOnContentClick': false
	});
	
	// $('a.fancybox_signin').each(function(){
	//        $(this).fancybox({
	// 	'hideOnContentClick': false
	//         // titleShow     : false,
	//         // width:    400,
	//         // height:   120,
	//         // autoDimensions: false,
	//         // overlayOpacity: 0.6,
	//         // href: 'test.php?id='+$(this).attr('rel')
	//       }); 
	//     });
	


});

