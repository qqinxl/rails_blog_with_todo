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
			var temp_data = "<tr class='{class}'><td>{icon}</td><td>{tag}</td><td>{title}</td><td>{due_date}</td><td class='last'>{link}</td></tr>";
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
					msg += temp_data.replace("{class}", c).replace("{icon}", m).replace("{title}", d.title).replace("{due_date}", t).replace("{tag}", d.tag.name).replace("{link}", "");
				}
			}		
			var table = $("#admin_todo_lists_table");
			table.find("tr:not(:first)").remove();
			table.append(msg);
		};
		get_icon = function(data) {
			var due_date, today;
			if (data.starred) {
				return "★";
			}
			due_date = new Date(data.due_date);
			today = new Date();
			today.setHours(0, 0, 0, 0);
			if (due_date < today) {
				return "▽";
			} else if (due_date.toDateString() === today.toDateString()) {
				return "☆";
			} else {
				return "";
			}
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
			reload: function(url) {
				$.ajax({
					type: "GET",
					url: url,
					dataType: 'json',
					success: function(data, textStatus, jqXHR) {
						rewrite_todo_list(data);
					},
					error: function(jqXHR, textStatus, errorThrown) {
						rewrite_todo_list("Load error");
					}
				});
			}
		}
	}());
})(jQuery);