module ApplicationHelper

	def flash_class(level)
    level = level.to_sym
    return 'alert alert-info' if level == :notice
    return 'alert alert-success' if level == :success
    return 'alert alert-error' if level == :error
    return 'alert alert-error' if level == :alert
  end

end
