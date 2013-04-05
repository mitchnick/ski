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
	fill_in "Email", 		with: user.email
	fill_in "Password",		with: user.password 
	within(".sign-in") do 
		click_button "Sign in"
	end
end