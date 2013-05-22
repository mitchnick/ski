require 'spec_helper'

describe "User Pages" do

	# Testing the login functionality here, including Facebook login 
	
	subject { page }

	describe "Sign up page" do 
		before { visit new_user_registration_path }

		it { should have_selector('title', text: full_title('Sign up'))}
	end
end
