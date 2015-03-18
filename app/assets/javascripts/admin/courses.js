// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//jQuery ->
$(document).ready(function (){
	$('#courses').dataTable( {
	  "iDisplayLength": 100,
	  "sDom": '<"top"fip>rt<"bottom"flp><"clear">',
	  "columnDefs": [
	  ]
	});
	$('#ccourses').dataTable({
	  "iDisplayLength": 100,				
	  "columnDefs": [
	    { "orderable": false, "targets": [4] }
	  ]
	});
	$('#rcourses').dataTable({
	  "iDisplayLength": 100,				
	  "columnDefs": [
	    { "orderable": false, "targets": [4] }
	  ]
	});
	$('#r1courses').dataTable({
	  "iDisplayLength": 100,				
	  "columnDefs": [
	    { "orderable": false, "targets": [1] }
	  ]
	});	
	$('#tcourses').dataTable({
	  "iDisplayLength": 100,				
	  "columnDefs": [
	    { "orderable": false, "targets": [4] }
	  ]
	});
});

$('#myTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });

    // store the currently selected tab in the hash value
    $("ul.nav-tabs > li > a").on("shown.bs.tab", function (e) {
        var id = $(e.target).attr("href").substr(1);
        window.location.hash = id;
    });

    // on load of the page: switch to the currently selected tab
    var hash = window.location.hash;
    $('#myTab a[href="' + hash + '"]').tab('show');