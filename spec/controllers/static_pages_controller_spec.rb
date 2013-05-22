require 'spec_helper'

describe StaticPagesController do

	describe "GET home" do 
		before :each do 
			@mountain = FactoryGirl.create(:mountain)
			@photo = FactoryGirl.create(:photo, mountain: @mountain)
		end
		it "gets all of the mountains and assigns it to @mountains" do 
			get :home
			assigns(:mountains).should eq([@mountain])
		end
		it "gets all of the photos for the homepage" do 
			get :home
			assigns(:photos_array).should eq([@photo])
		end
		context "user is logged in" do 
			before :each do 
				@user = FactoryGirl.create(:user)
				sign_in @user 
			end
			it "sets the landing page variable to false" do 
				get :home
				assigns(:landing_page).should eq(false)
			end
			it "sets the photos variable for the home page" do 
				get :home
				assigns(:photos).should eq([@photo])
			end
		end
		context "user is not logged in" do 
			it "sets the landing page variable to true" do 
				get :home
				assigns(:landing_page).should eq(true)
			end
			it "sets no footer variable to true" do 
				get :home
				assigns(:no_footer).should eq(true)
			end
			it "gets a photo within the top 10 and assigns this to @photo" do 
				get :home 
				assigns(:photo).should_not be_nil 
			end
			it "sets the variable @photo_user" do 
				get :home 
				assigns(:photo_user).should eq(@user)
			end
		end
	end

	describe "GET search" do 
		before :each do 
			@region1 = FactoryGirl.create(:region, name: "Breck 1 Region")
			@region2 = FactoryGirl.create(:region, name: "Breck 2 Region")
			@mountain1 = FactoryGirl.create(:mountain, name: "Breck 1 Mountain")
			@mountain2 = FactoryGirl.create(:mountain, name: "Breck 2 Mountain")
		end
		it "gets all of the mountains and assigns them to @mountains" do 
			get :search, search: "Breck"
			assigns(:mountains).length.should == 2
		end
		it "gets all of the regions and assigns them to @regions" do 
			get :search, search: "Breck"
			assigns(:regions).length.should == 2
		end
		it "gets and assigns the search result length" do 
			get :search, search: "Breck"
			assigns(:search_results).length.should == 4
		end
		it "if only one mountain found and there is no regions found, it redirects to that mountain" do 
			get :search, search: "Breck 1 Mountain"
			response.should redirect_to assigns(:mountains).first
		end
		it "if only one region found and there is no mountains found, it redirects to that region" do 
			get :search, search: "Breck 1 Re"
			response.should redirect_to assigns(:regions).first
		end
		it "if multiple mountains or regions are found, it goes to the search results page" do 
			get :search, search: "Breck 1"
			response.should render_template :search
		end
	end

	describe "GET about" do 
		it "should render the correct template" do 
			get :about
			response.should render_template :about
		end
	end

	describe "GET contact" do 
		it "should render the correct template" do 
			get :contact
			response.should render_template :contact
		end
	end
end