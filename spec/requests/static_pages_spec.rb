require 'spec_helper'
include Warden::Test::Helpers

describe "Static pages" do

	subject { page }

	shared_examples_for "all static pages" do
		it { should have_selector('h1', 		text: heading)}
		it { should have_selector('title', 		text: full_title(page_title))}
	end

	before :each do
		@user = FactoryGirl.create(:user)
		@region = FactoryGirl.create(:region)
		@mountain = FactoryGirl.create(:mountain, region: @region)
		@photo = FactoryGirl.create(:photo, mountain: @mountain, user: @user)
	end

	describe "Home page" do
		before :each do
			visit root_path
		end
		let(:heading) {'Where to Ski'}
		let(:page_title) {''}

		it_should_behave_like "all static pages"
		it {should_not have_selector('title', text: '| Home')}

		describe "when NOT logged in" do
			it "has the correct header links" do
				visit root_path
				click_link 'About'
				should have_selector('title', text:'About us')
				click_link 'Home'
				should have_selector('title', text:'')
				visit root_path
				click_link 'Sign up now!'
				should have_selector('title', text:'Sign up')
			end

			describe "sign in page" do
				it "can show the terms and conditions in a modal" do
					visit new_user_registration_path
					should have_link('terms')
				end
			end
		end

		describe "when logged in" do
			before(:each) do
				login_as @user, :scope => :user
				visit root_path
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
				should have_link('Mitch Nick', {href: 'http://www.mnwebdev.com', class: 'footer'})
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

		it { should have_selector('h2', 		text: heading)}
		it { should have_selector('title', 		text: full_title(page_title))}
	end

end
