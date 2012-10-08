module ApplicationHelper
	def is_homepage?
		(controller.action_name =~ /index/ and controller.controller_name =~ /home/)
	end
	def is_active_class(action_name)
		if (params[:controller] == action_name)
			"active"
		else
			"" 
		end
	end
end
