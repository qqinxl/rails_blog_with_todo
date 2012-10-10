# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$("#new_admin_todo_tag").bind "ajax:success", (event, ajax, status) ->
		if ajax.errors
			$("#flash_message").html("<div class='message error'><p>" + ajax.errors + "</p></div>");
		else
			data = $.parseJSON(ajax.data)
			$("#tags_list").append("<li><a href='#'>" + data.name + "</a></li>")
			$("#flash_message").html("<div class='message notice'><p>A tag named " + data.name + " was added successfully.</p></div>")
			$("#new_admin_todo_list_tab").show()
			$("#admin_todo_list_todo_tag_id").append("<option value='" + data.id + "'>" + data.name + "</option>")
		false
	
	$("#new_admin_todo_list").bind "ajax:success", (event, ajax, status) ->
		if ajax.errors
			$("#flash_message").html("<div class='message error'><p>" + ajax.errors + "</p></div>");
		else
			$("#admin_todo_lists_tab").click()	
		false
	
	$("#new_todo_list_content").hide()
	
	$("#new_admin_todo_list_tab").live 'click', (e) =>
		$("#new_todo_list_content").show()
		li = $(e.target).parent()
		li.parent().find("li").removeClass("active")
		li.addClass("active")
		false

	$("#admin_todo_lists_tab").live 'click', (e) =>
		$("#new_todo_list_content").hide()
		th = $(e.target)
		li = th.parent()
		li.parent().find("li").removeClass("active")
		li.addClass("active")
		$.ajax th.attr("herf"),
			type: 'GET'
			dataType: 'json'
			error: (jqXHR, textStatus, errorThrown) ->
				rewrite_todo_list("Load error")
			success: (data, textStatus, jqXHR) ->
				rewrite_todo_list(data)
		false
	
	rewrite_todo_list = (data) =>
		temp_msg = "<tr><td class='first odd' colspan=5>{msg}</td></tr>"
		temp_data = "<tr class='{class}'><td>{icon}</td><td>{tag}</td><td>{title}</td><td>{due_date}</td><td class='last'>{link}</td></tr>"
		if typeof(data) == 'string'
			msg = temp_msg.replace("{msg}", data)
		else if data.length == 0
			msg = temp_msg.replace("{msg}", "There is no data to list.")
		else
			msg = ""
			for d, i in data
				c = if i == 0 then "first" else if i%2 == 0 then "odd" else "even"
				t = $.format.date(d.due_date, 'yyyy-MM-dd hh:mm')
				m = get_icon(d)
				msg += temp_data.replace("{class}", c).replace("{icon}", m).replace("{title}", d.title).replace("{due_date}", t).replace("{tag}", d.tag.name).replace("{link}", "")
				
		table = $("#admin_todo_lists_table");
		table.find("tr:not(:first)").remove();
		table.append(msg)
		$("#admin_todo_lists_title").html("♪ All TODOs")
	
	get_icon = (data) =>
		return "★" if (data.starred) 
		due_date = new Date(data.due_date)
		today = new Date()
		today.setHours(0,0,0,0)
		if (due_date < today)
			return "▽"
		else if (due_date.toDateString() == today.toDateString() )
			return "☆"
		else
			return ""
		
		
			