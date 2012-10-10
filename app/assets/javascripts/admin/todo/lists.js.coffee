# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$("#new_admin_todo_tag").bind "ajax:success", (event, ajax, status) ->
		if ajax.errors
			$.falsh_message.html(ajax.errors, "error")
		else
			data = $.parseJSON(ajax.data)
			$.todo_list.append_tag(data.id, data.name)
			$.falsh_message.html("One tag named " + data.name + " was added successfully.", "notice")
		false
	
	$("#new_admin_todo_list").bind "ajax:success", (event, ajax, status) ->
		if ajax.errors
			$.falsh_message.html(ajax.errors, "error")
		else
			$("#admin_todo_lists_tab").click()	
			$.falsh_message.html("One todo was added successfully.", "notice")
		false
	
	$("#new_todo_list_content").hide()
	
	$("#cancel_new_admin_todo_list").live 'click', (e) =>
		$("#new_todo_list_content").hide()
		$.todo_list.active("admin_todo_lists_tab")
		false
	
	$("#new_admin_todo_list_tab").live 'click', (e) =>
		$("#new_todo_list_content").show()
		$.todo_list.active("new_admin_todo_list_tab")
		false

	$("#admin_todo_lists_tab").live 'click', (e) =>
		$("#new_todo_list_content").hide()
		$.todo_list.active("admin_todo_lists_tab")
		$.todo_list.reload($(e.target).attr("herf"))
		false
		
			