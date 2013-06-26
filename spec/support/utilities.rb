def full_title(page_title)
	base_title = "Where to Ski"
	if page_title.empty?
		base_title
	else 
		"#{base_title} | #{page_title}"
	end
end

def sign_in(user)
	visit user_session_path
	within('.login-container') do 
		fill_in "Email", 		with: user.email
		fill_in "Password",		with: user.password 
		click_button "Log in"
	end
end