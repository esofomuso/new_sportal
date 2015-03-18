// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function (){
	$('#electives').dataTable({
	  "iDisplayLength": 100,		
	  "columnDefs": [
	    { "orderable": false, "targets": [3] }
	  ]
	});
});