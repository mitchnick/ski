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

	def photo_alt_description(photo)
		photo.mountain.name + " mountain and ski resort in " + photo.mountain.region.name + ": " + photo.name + ". " + photo.description + "  -Photo by " + photo.user.name
	end
	
	def search_results_show_mountain?
		@mountains.length > 0 || @regions.length == 0
	end
end
