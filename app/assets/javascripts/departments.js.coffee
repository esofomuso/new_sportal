$.ajax(url: "/departments").done (html) ->
  $("#department_form").append html


$(document).ready ->

  $(document).bind "ajaxSuccess", "form.department_form", (event, xhr, settings) ->
    $department_form = $(event.data)
    $error_container = $("#error_explanation", $department_form)
    $error_container_ul = $("ul", $error_container)
    $("<p>").html(xhr.responseJSON.title + " saved.").appendTo $department_form
    if $("li", $error_container_ul).length
      $("li", $error_container_ul).remove()
      $error_container.hide()

  $(document).bind "ajaxError", "form.department_form", (event, jqxhr, settings, exception) ->
    $department_form = $(event.data)
    $error_container = $("#error_explanation", $department_form)
    $error_container_ul = $("ul", $error_container)
    $error_container.show()  if $error_container.is(":hidden")
    $.each jqxhr.responseJSON, (index, message) ->
      $("<li>").html(message).appendTo $error_container_ul