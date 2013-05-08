module ApplicationHelper

# Helps set the page title across the application 
	def google_analytics(id)
    content_tag :script, :type => 'text/javascript' do
      "var _gaq = _gaq || [];
      _gaq.push(['_setAccount', '#{id}']);
      _gaq.push(['_trackPageview']);
      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();".html_safe
    end if id && Rails.env == 'production'
  end

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
