module ApplicationHelper
	def error_list user,field
		user.errors[field].join(",")
	end
end
