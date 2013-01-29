module ApplicationHelper

# Helps set the page title across the application 
	def full_title(page_title)
		base_title = "Where to Ski"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

end
