module ApplicationHelper
	def is_homepage?
		(controller.action_name =~ /index/ and controller.controller_name =~ /home/)
	end
	def is_active_class(action_name)
		"active" if (params[:controller] == action_name)
		""
	end
end
