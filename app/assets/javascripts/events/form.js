$(function() {
	$( ".datepicker" ).datepicker({
		onClose: function(dateText, inst) { $(inst.input).change().focusout(); }
	});
});