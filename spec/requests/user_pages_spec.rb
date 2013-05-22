require 'spec_helper'
require 'capybara-screenshot/rspec'

describe "User Pages" do

	# Testing the login functionality here, including Facebook login 

	subject { page }

	describe "Sign up page" do 
		before { visit new_user_registration_path }

		it { should have_selector('title', text: full_title('Sign up'))}

		context "new user sign up via email" do 
			it "creates the new user and brings them to the home page" do 
				expect {
					within('.main-content-container') do 
						fill_in "Name", with: "My Sample User"
						fill_in "Email", with: "auser@example.com"
						fill_in "Password", with: "foobarish"
					end
					click_button "Sign up"
				}.to change(User, :count).by(1)
				within 'h1' do 
					page.should have_content "Hottest Pics"
				end
			end
		end
		context "signing in with facebook" do 
			it "increases the user count when clicking on login with facebook" do 
				visit new_user_registration_path
				expect {
					within('.main-content-container') do 
						click_link "Sign up with Facebook"
					end
				}.to change(User, :count).by(1)
				within 'h1' do 
				page.should have_content "Hottest Pics"
				end	
			end
		end
	end
end
