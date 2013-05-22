require 'spec_helper'

describe PhotosController do
	before :each do
		@user = FactoryGirl.create(:user)
		@mountain = FactoryGirl.create(:mountain)
		@photo = FactoryGirl.create(:photo, mountain: @mountain, user: @user)
	end

	describe "GET show" do
		it "gets the mountain and assigns it to @mountain" do 
			get :show, mountain_id: @mountain, id: @photo
			assigns(:mountain).should eq(@mountain)
		end
		it "gets the photo and assigns it to @photo" do 
			get :show, mountain_id: @mountain, id: @photo
			assigns(:photo).should eq(@photo)
		end
		it "gets the gnars against the photo and assigns it to @gnars" do 
			@gnar = FactoryGirl.create(:gnar, user: @user, photo: @photo)
			get :show, mountain_id: @mountain, id: @photo
			assigns(:gnars).should eq([@gnar])
		end
		it "updates the views count" do 
			expect{
				get :show, mountain_id: @mountain, id: @photo
			}.to change(ViewCount, :count).by(1)
		end
		it "renders the show view" do 
			get :show, mountain_id: @mountain, id: @photo
			response.should render_template :show
		end
	end

	describe "GET new" do 
		context "when user is logged in" do 
			before :each do 
				sign_in @user
			end
			it "gets the mountain and assigns it to @mountain" do 
				get :new, mountain_id: @mountain 
				assigns(:mountain).should eq(@mountain)
			end
			it "gets the current user and assigns it to @user" do 
				get :new, mountain_id: @mountain
				assigns(:user).should eq(@user.id)
			end
			it "renders the new template" do 
				get :new, mountain_id: @mountain
				response.should render_template :new
			end
		end
		context "when user is not logged in" do 
			it "redirects the user to the sign in page" do 
				get :new, mountain_id: @mountain
				response.should redirect_to new_user_session_path
			end
		end
	end

	describe "POST create" do 
		context "with valid attributes and user is logged in" do 
			before :each do
				sign_in @user
			end
			it "gets the mountain and assigns it to @mountain" do 
				post :create, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id)
				assigns(:mountain).should eq(@mountain)
			end
			it "saves the photo with proper attributes" do 
				expect{
					post :create, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id)
				}.to change(Photo,:count).by(1)
			end
			it "adds the creator and photographer relationship to photo_relationships" do 
				post :create, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id)
				PhotoRelationship.count.should == 2
			end
			it "adds the mountain to the listing of mountains the user has been to" do 
				post :create, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id)
				MyMountain.count.should == 1
			end
			it "shows a flash notice" do 
				post :create, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id)
				flash[:notice].should_not be_nil
			end
			it "redirects the user to the photo" do 
				post :create, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id)
				response.should redirect_to [@mountain, Photo.last]
			end
		end
		context "with incorrect attributes" do 
			it "redirects to the sign in page when user not logged in" do 
				post :create, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id)
				response.should redirect_to new_user_session_path
			end
			it "gets the mountain and assigns it to @mountain" do 
				sign_in @user 
				post :create, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id)
				assigns(:mountain).should eq(@mountain)
			end
			it "does not save the photo" do 
				sign_in @user 
				expect {
					post :create, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, name: nil, mountain_id: @mountain.id, user_id: @user.id)
				}.to change(Photo,:count).by(0)
			end
			it "renders the new template for photo" do 
				sign_in @user 
				post :create, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, name: nil, mountain_id: @mountain.id, user_id: @user.id)
				response.should render_template :new
			end
		end
	end

	describe "PUT update" do 
		context "with correct attributes and user is signed in" do 
			before :each do 
				sign_in @user
			end
			it "gets the mountain and assigns it to @mountain" do 
				put :update, id: @photo, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id)
				assigns(:mountain).should eq(@mountain)
			end
			it "gets the photo and assigns it to @photo" do 
				put :update, id: @photo, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id)
				assigns(:photo).should eq(@photo)
			end
			it "updates the photo" do 
				put :update, id: @photo, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, name: "Mitch Nick", mountain_id: @mountain.id, user_id: @user.id)
				@photo.reload
				@photo.name.should eq("Mitch Nick")
			end
			it "shows a flash notice" do 
				put :update, id: @photo, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id)
				flash[:notice].should_not be_nil
			end
			it "redirects to the photo" do 
				put :update, id: @photo, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id)
				response.should redirect_to [@mountain, Photo.last]
			end
		end
		context "with incorrect attributes" do 
			it "does not let someone who is not the owner update the mountain" do 
				@user2 = FactoryGirl.create(:user)
				@name = @photo.name
				sign_in @user2
				put :update, id: @photo, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, name: "Mitch Nick", mountain_id: @mountain.id, user_id: @user.id)							
				@photo.reload
				@photo.name.should eq(@name)
			end
			it "gets the mountain and assigns it to @mountain" do 
				sign_in @user
				put :update, id: @photo, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, name: nil, mountain_id: @mountain.id, user_id: @user.id)
				assigns(:mountain).should eq(@mountain)
			end
			it "gets the photo and assigns it to @photo" do
				sign_in @user
				put :update, id: @photo, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, name: nil, mountain_id: @mountain.id, user_id: @user.id)
				assigns(:photo).should eq(@photo)
			end
			it "does NOT updates the photo" do
				sign_in @user
				@name = @photo.name
				put :update, id: @photo, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, name: nil, mountain_id: @mountain.id, user_id: @user.id)							
				@photo.reload
				@photo.name.should eq(@name)
			end
			it "renders the edit page" do 
				sign_in @user 
				put :update, id: @photo, mountain_id: @mountain, photo: FactoryGirl.attributes_for(:photo, name: nil, mountain_id: @mountain.id, user_id: @user.id)
				response.should render_template("edit")
			end
		end
	end

	describe "GET edit" do  
		context "with valid attributes and user signed in" do 
			before :each do 
				sign_in @user 
			end
			it "gets the mountain and assigns it to @mountain" do 
				get :edit, id: @photo, mountain_id: @mountain 
				assigns(:mountain).should eq(@mountain)
			end
			it "gets the photo and assigns it to @photo" do
				get :edit, id: @photo, mountain_id: @mountain 
				assigns(:photo).should eq(@photo)
			end
			it "renders the edit template" do 
				get :edit, id: @photo, mountain_id: @mountain 
				response.should render_template("edit")
			end
		end
		context "when user not signed in" do 
			it "redirects the user to the log in page" do 
				get :edit, id: @photo, mountain_id: @mountain 
				response.should redirect_to new_user_session_path
			end
		end
		context "when user is not the individual who loaded the photo" do 
			before :each do 
				@user2 = FactoryGirl.create(:user)
				sign_in @user2
			end
			it "gets the mountain and assigns it to @mountain" do 
				get :edit, id: @photo, mountain_id: @mountain 
				assigns(:mountain).should eq(@mountain)
			end
			it "gets the photo and assigns it to @photo" do 
				get :edit, id: @photo, mountain_id: @mountain 
				assigns(:mountain).should eq(@mountain)
			end
			it "shows a flash message" do 
				get :edit, id: @photo, mountain_id: @mountain 
				flash[:notice].should_not be_nil 
			end
			it "redirects the user to the photo page" do 
				get :edit, id: @photo, mountain_id: @mountain 
				response.should redirect_to [@mountain, @photo]
			end
		end
	end

	describe "DELETE destroy" do 
		context "with valid attirbutes and correct user" do 
			before :each do 
				sign_in @user 
			end
			it "gets the mountain and assigns it to @mountain" do 
				delete :destroy, id: @photo, mountain_id: @mountain
				assigns(:mountain).should eq(@mountain)
			end
			it "gets the photo and assigns it to @photo" do 
				delete :destroy, id: @photo, mountain_id: @mountain
				assigns(:photo).should eq(@photo)
			end
			it "destroys the photo" do 
				expect {
					delete :destroy, id: @photo, mountain_id: @mountain 
				}.to change(Photo,:count).by(-1)
			end
			it "redirects the user to @mountain" do 
				delete :destroy, id: @photo, mountain_id: @mountain 
				response.should redirect_to @mountain 
			end
		end
		context "when user not signed in" do 
			it "does not change the photo count" do 
				expect {
					delete :destroy, id: @photo, mountain_id: @mountain
					}.to change(Photo,:count).by(0)
			end
			it "redirects the user to the log in page" do 
				delete :destroy, id: @photo, mountain_id: @mountain
				response.should redirect_to new_user_session_path
			end
		end
		context "when user is not the individual who loaded the photo" do 
			before :each do 
				@user2 = FactoryGirl.create(:user)
				sign_in @user2
			end
			it "shows a flash message" do 
				delete :destroy, id: @photo, mountain_id: @mountain
				flash[:notice].should_not be_nil 
			end
			it "redirects the user to the photo page" do 
				delete :destroy, id: @photo, mountain_id: @mountain
				response.should redirect_to [@mountain, @photo]
			end
		end
	end

	describe "PUT add rider" do 
		context "with valid attributes and correct user" do 
			before :each do 
				@rider_user = FactoryGirl.create(:user)
				sign_in @user 
			end
			it "gets the mountain" do 
				xhr :put, :add_rider, id: @photo, mountain_id: @mountain, photo_id: @photo, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id, rider_id: @rider_user)
				assigns(:mountain).should eq(@mountain)
			end
			it "gets the photo" do 
				xhr :put, :add_rider, id: @photo, mountain_id: @mountain, photo_id: @photo, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id, rider_id: @rider_user)
				assigns(:photo).should eq(@photo)
			end
			it "adds the rider to the photo" do 
				xhr :put, :add_rider, id: @photo, mountain_id: @mountain, photo_id: @photo, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id, rider_id: @rider_user)
				@photo.reload
				@photo.rider.should eq(@rider_user)
			end
		end
		context "when user not signed in" do 
			it "does not add the rider" do 
				xhr :put, :add_rider, id: @photo, mountain_id: @mountain, photo_id: @photo, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id, rider_id: @rider_user)
				@photo.reload 
				@photo.rider.should be_nil
			end
		end
		context "when user is not the individual who loaded the photo" do 
			before :each do 
				@user2 = FactoryGirl.create(:user)
				sign_in @user 
			end
			it "does not add the rider" do 
				xhr :put, :add_rider, id: @photo, mountain_id: @mountain, photo_id: @photo, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id, rider_id: @rider_user)
				@photo.reload 
				@photo.rider.should be_nil
			end
		end
	end
	
	describe "POST remove rider" do 
		context "with valid attributes and correct user" do 
			before :each do 
				sign_in @user 
			end
			it "gets the mountain" do 
				xhr :put, :remove_rider, id: @photo, mountain_id: @mountain, photo_id: @photo, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id, rider_id: @rider_user)
				assigns(:mountain).should eq(@mountain)
			end
			it "gets the photo" do 
				xhr :put, :remove_rider, id: @photo, mountain_id: @mountain, photo_id: @photo, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id, rider_id: @rider_user)
				assigns(:photo).should eq(@photo)
			end
			it "deletes the rider from the photo" do 
				xhr :put, :remove_rider, id: @photo, mountain_id: @mountain, photo_id: @photo, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id, rider_id: @rider_user)
				@photo.reload 
				@photo.rider.should be_nil 
			end
		end
		context "when user not signed in" do 
			it "does not remove the rider" do 
				@user2 = FactoryGirl.create(:user)
				@photo.rider = @user2
				xhr :put, :remove_rider, id: @photo, mountain_id: @mountain, photo_id: @photo, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id, rider_id: @rider_user)
				@photo.reload 
				@photo.rider.should_not be_nil
			end
		end
		context "when user is not the individual who loaded the photo" do 
			before :each do 
				@user2 = FactoryGirl.create(:user)
				sign_in @user2
			end
			it "does not remove the rider" do 
				@user3 = FactoryGirl.create(:user)
				@photo.rider = @user3
				xhr :put, :remove_rider, id: @photo, mountain_id: @mountain, photo_id: @photo, photo: FactoryGirl.attributes_for(:photo, mountain_id: @mountain.id, user_id: @user.id, rider_id: @rider_user)
				@photo.reload 
				@photo.rider.should_not be_nil
			end
		end
	end
end