# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$("#new_admin_todo_tag").bind "ajax:success", (event, ajax, status) ->
		if ajax.errors
			$("#flash_message").html("<div class='message notice'><p>" + ajax.errors + "</p></div>");
		else
			$("#tags_list li:last").before("<li><a href='#'>" + ajax.name + "</a></li>")
			$("#flash_message").html("<div class='message notice'><p>A tag was added successfully.</p></div>");
		false