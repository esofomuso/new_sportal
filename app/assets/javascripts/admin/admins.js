// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function (){
	$('#admins').dataTable({
	  "columnDefs": [
	    { "orderable": false, "targets": [0] }
	  ]
	});
});