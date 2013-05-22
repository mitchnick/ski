require 'spec_helper'
include Warden::Test::Helpers

describe "Static pages" do

	subject { page }

	shared_examples_for "all static pages" do 
		it { should have_selector('h1', 		text: heading)}
		it { should have_selector('title', 		text: full_title(page_title))}
	end

	describe "Home page" do  
		before { visit root_path }
		let(:heading) {'Where to Ski'}
		let(:page_title) {''}
		let(:user) { FactoryGirl.create(:user)}
		
		it_should_behave_like "all static pages"
		it {should_not have_selector('title', text: '| Home')}

		describe "when NOT logged in" do 
			it "has the correct header links" do 
				visit root_path
				click_link 'About'
				should have_selector('title', text:'About us')
				click_link 'Home'
				should have_selector('title', text:'')
				click_link 'Sign in'
				should have_selector('title', text:'Sign in')
				visit root_path
				click_link 'Sign up now!'
				should have_selector('title', text:'Sign up')
			end

			it "has the correct footer links " do
				visit root_path
				should have_link('Mitch Nick', {href: 'http://about.me/mitchnick', class: 'footer'})
				visit root_path
				click_link 'Contact'
				should have_selector('title', text:'Contact')
			end

			describe "sign in page" do 
				it "can show the terms and conditions in a modal" do
					visit new_user_registration_path
					should have_selector('h3', text:'Terms and Conditions')
				end
			end
		end

		describe "when logged in" do 
			before(:each) do 
				login_as user, :scope => :user
				visit root_path 
			end

			describe "it has the correct header" do 
				it { should have_selector('h3', text:'Home') }
			end

			it "has the correct header links" do 
				visit root_path
				click_link 'About'
				should have_selector('title', text:'About us')
				click_link 'Home'
				should have_selector('title', text:'')
			end 

			it { should have_link('Sign out', href: destroy_user_session_path, method: "delete") }

			it "has the correct footer links " do
				visit root_path
				should have_link('Mitch Nick', {href: 'http://about.me/mitchnick', class: 'footer'})
				visit root_path
				click_link 'Contact'
				should have_selector('title', text:'Contact')
			end
		end
	end

	describe "About page" do 
		before { visit about_path }
		let(:heading) {'About us'}
		let(:page_title) {'About us'}

		it_should_behave_like "all static pages"
	end

	describe "Contact page" do 
		before { visit contact_path }
		let(:heading) {'Contact'}
		let(:page_title) {'Contact'}

		it_should_behave_like "all static pages"
	end
	
end
