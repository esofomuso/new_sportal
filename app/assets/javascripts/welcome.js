// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// Get the div element that will serve as the drop target.

getCourses = function () {
	var dept = $('.ng-scope .active .ng-binding').attr('dept_id');
	console.log(dept);
	$.ajax({ url: "/get_courses.js?dept_id="+ dept });
	return true
};

toggleCourses = function () {
	$('.courses').hide();
	dept = '.' + $('.ng-scope .active .ng-binding').html();
	$(dept).show();
};

window.onload = function() {
	toggleCourses();
};
//$(document).ready ->
//  toggleCourses();

