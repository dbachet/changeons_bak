$(document).ready(function() {
	$(function(){
		 // Change to hard coded link
		bind_delete_avatar_link();
	});
	avatar_form();
	
});

function progressHandlingFunction(e){
    if(e.lengthComputable){
        $('#progressBar').attr({value:e.loaded,max:e.total});
		$('#percent').html(100 * e.loaded / e.total + "%");
    }
}

function avatar_form(){
	$(function(){
		$(':file').change(function(event){
		    var file = this.files[0];
		    name = file.name;
		    size = file.size;
		    type = file.type;
		    //your validation
		// alert("name:" + name + ", size:" + size + ", type:" + type);
		// event.preventDefault();
	    var formData = new FormData($('#new_avatar')[0]);
		$('#progressBar').fadeIn();
		$('#percent').fadeIn();
		$('#status').html("L'image est en cours de téléchargement...");
	    $.ajax({
	        url: '/avatar',  //server script to process data
	        type: 'POST',
	        xhr: function() {  // custom xhr
	            myXhr = $.ajaxSettings.xhr();
	            if(myXhr.upload){ // check if upload property exists
	                myXhr.upload.addEventListener('progress',progressHandlingFunction, false); // for handling the progress of the upload
	            }
	            return myXhr;
	        },
	        //Ajax events
	        // beforeSend: beforeSendHandler,
	        // 		        success: completeHandler,
	        // 		        error: errorHandler,
	        // Form data
	        data: formData,
	        //Options to tell JQuery not to process data or worry about content-type
	        cache: false,
	        contentType: false,
	        processData: false
	    });
		});
	});
}

function bind_delete_avatar_link() {
	$('#delete_avatar_link').click(function(event){
		event.preventDefault();
		$.ajax({
	        url: '/avatar',  //server script to process data
	        type: 'DELETE',
	        //Ajax events
	        // beforeSend: beforeSendHandler,
	        // 		        success: completeHandler,
	        // 		        error: errorHandler,
	        // Form data
	        // data: formData,
	        //Options to tell JQuery not to process data or worry about content-type
	        cache: false,
	        contentType: false,
	        processData: false
	    });
	});
}