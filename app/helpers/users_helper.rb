module UsersHelper

	def user_image(user, format, size)
		if user.photo?			
			# do if there is a photo in the database
			image_tag(user.photo, alt: user.name, class: "#{format}", width: "#{size}", height: "#{size}")
		else
			# if they haven't specified a photo, show their gravatar, which includes default mystery man
			# gravatar_id = Digest::MD5::hexdigest("mitchnick@gmail.com".downcase)
			gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=mm&s=#{size}"
    	image_tag(gravatar_url, alt: user.name, class: "gravatar #{format}")
    end
	end

end
