// <script type="text/javascript">
	$(document).ready(function() {
		$(function(){
			add_source_links(""); // Change to hard coded link
			bind_delete_presentation_picture_link();
		});
		
		$(function(){
			$(':file').change(function(event){
			    var file = this.files[0];
			    name = file.name;
			    size = file.size;
			    type = file.type;
			    //your validation
			// alert("name:" + name + ", size:" + size + ", type:" + type);
			event.preventDefault();
		    var formData = new FormData($('#new_presentation_picture')[0]);
			$('#progressBar').fadeIn();
			$('#percent').fadeIn();
			$('#picture_upload_status').html("L'image est en cours de téléchargement...");
		    $.ajax({
		        url: '/presentation_picture',  //server script to process data
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
		
		// $('input#submit_picture').click(function(event){
		// 	
		// });
	});
	
	function progressHandlingFunction(e){
	    if(e.lengthComputable){
	        $('#progressBar').attr({value:e.loaded,max:e.total});
			$('#percent').html(100 * e.loaded / e.total + "%");
	    }
	}
// </script>