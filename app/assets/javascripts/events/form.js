$(document).ready(function(){
	$( ".datepicker" ).datepicker({
		onClose: function(dateText, inst) { $(inst.input).change().focusout(); }
	});
	
	toggle_department_select();
	
	$("#event_addr_country").change(function(){
		toggle_department_select();
	});
});

function toggle_department_select(){
	if ($("#event_addr_country").val() == "France" || $("#event_addr_country").val() == "France, Metropolitan") {
		$('#event_department').closest("div").slideDown();
	} else {
		$('#event_department').closest("div").slideUp();
	}
}