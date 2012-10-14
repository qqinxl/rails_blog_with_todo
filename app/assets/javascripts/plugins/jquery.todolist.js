(function($){	
	
	$.falsh_message = (function() {		
		return {
			html: function(msg, clz) {
				$("#flash_message").html("<div class='message " + clz + "'><p>" + msg + "</p></div>").fadeIn().delay(10000).fadeOut();
			}
		};
	}());
	
	$.todo_list = (function() {			
		rewrite_todo_list = function(data) {
			var msg, i, len;
			var temp_msg = "<tr><td class='first odd' colspan=5>{msg}</td></tr>";
			var temp_data = "<tr class='{class}'><td>{icon}</td><td>{tag}</td><td><a href='/admin/todo/lists/{id}' type='show'>{title}</a></td><td>{due_date}</td><td class='last'>{link}</td></tr>";
			if (typeof(data) == 'string') {
				msg = temp_msg.replace("{msg}", data);
			} else if (data.length == 0) {
				msg = temp_msg.replace("{msg}", "There is no data to list.");
			} else {
				msg = "";
				for (i = 0, len = data.length; i < len; i++) {
					d = data[i];
					c = i === 0 ? "first" : i % 2 === 0 ? "odd" : "even";
					t = $.format.date(d.due_date, 'yyyy-MM-dd hh:mm');
					m = get_icon(d);
					msg += temp_data.replace("{class}", c)
								    .replace("{icon}", m)
								    .replace("{title}", d.title)
								    .replace("{id}", d.id)
								    .replace("{due_date}", t)
								    .replace("{tag}", d.tag.name)
								    .replace("{link}", "");
				}
			}		
			var table = $("#admin_todo_lists_table");
			table.find("tr:not(:first)").remove();
			table.append(msg);
			_ajax_table_list();
		};
		get_icon = function(data) {
			var due_date, today, icon = "";
			if (data.completed_at) {
				icon += "●";
			}
			if (data.starred) {
				icon += "☆";
			}
			due_date = new Date(data.due_date);
			today = new Date();
			today.setHours(0, 0, 0, 0);
			if (due_date < today) {
				icon += "▽";
			} else if (due_date.toDateString() === today.toDateString()) {
				icon += "△";
			}
			return icon;
		};
		_ajax_table_list = function() {
			$('#admin_todo_lists_table a[type="show"]').live('click', function(e) {
				$("#new_todo_list_content").hide();
				$.todo_list.ajaxLink(e.target, "GET", $.todo_list.show);
				return false;
			}); 
		};
		return {
			append_tag: function(id, name) {
				var tag_list = $("#tags_list"), tag_select = $("#admin_todo_list_todo_tag_id"), new_tag_tab = $("#new_admin_todo_list_tab");
				
				tag_list.append("<li><a href='#'>" + name + "</a></li>");
				tag_select.append("<option value='" + id + "'>" + name + "</option>");
				new_tag_tab.show();
			},
			active: function(id) {
				var th = $("#" + id);
				var li = th.parent();
				li.parent().find("li").removeClass("active");
				li.addClass("active");
			},
			reload: function() {
				$.ajax({
					type: "GET",
					url: "/admin/todo/lists",
					dataType: 'json',
					success: function(data, textStatus, jqXHR) {
						rewrite_todo_list(data);
					},
					error: function(jqXHR, textStatus, errorThrown) {
						rewrite_todo_list("Load error");
					}
				});
			},
			ajaxLink: function(dom, type, successFuc) {
				var url = $(dom).attr("href");
				$.ajax({
					type: type,
					url: url,
					dataType: 'json',
					success: function(data, textStatus, jqXHR) {
						successFuc(data);
					},
					error: function(jqXHR, textStatus, errorThrown) {
						$.falsh_message.html("Fail to action:" + url, "error");
					}
				});
			},
			show: function(data) {
				var temp_show_title_msg = '<h2 class="title">{title}</h2>';
				var temp_show_content_msg = '<div class="inner"><table class="table"><tr class="even"><td>Tag:</td><td>{tag}</td></tr><tr class="even"><td>Description:</td><td>{description}</td></tr><tr class="even"><td>Due date:</td><td>{due_date}</td></tr></table></div>';
				var msg;
				if (data.errors) {
					msg = temp_show_title_msg.replace("{title}", data.errors);
				} else {
					var d = data.data;
					if(!$.isPlainObject(d)) {
						d = $.parseJSON(d);
					}
					msg = temp_show_title_msg.replace("{title}", get_icon(d) + d.title);
					msg += temp_show_content_msg.replace("{tag}", d.tag.name).replace("{description}", d.description).replace("{due_date}", $.format.date(d.due_date, 'yyyy-MM-dd hh:mm'));
				}
				$("#show_todo_list_content").html(msg).show();
			}
		}
	}());
})(jQuery);