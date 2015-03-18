// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function (){
	$('#students').dataTable({
	  "iDisplayLength": 100,
	  "columnDefs": [
	    { "orderable": false, "targets": [4] }
	  ]
	});
	
	$("#selectall").click(function () {
	      $('.active').attr('checked', $('#selectall').checked);
	});
});

$(function(){
 
    // add multiple select / deselect functionality
    $("#selectall").click(function () {
          $('.active').attr('checked', $('#selectall').checked);
    });
 		
    // if all checkbox are selected, check the selectall checkbox
    // and viceversa
    $(".active").click(function(){
 
        if($(".active").length == $(".active:checked").length) {
            $("#selectall").attr("checked", "checked");
        } else {
            $("#selectall").removeAttr("checked");
        }
 
    });
});

$(function() { 
    
    //for bootstrap 3 use 'shown.bs.tab' instead of 'shown' in the next line
    $('a[data-toggle="tab"]').on('click', function (e) {
        //save the latest tab; use cookies if you like 'em better:
        localStorage.setItem('lastTab', $(e.target).attr('href'));
    });

    //go to the latest tab, if it exists:
    var lastTab = localStorage.getItem('lastTab');

    if (lastTab) {
        $('a[href="'+lastTab+'"]').click();
    }
});