require 'spec_helper'

describe GnarsController do
	before :each do
 		@user = FactoryGirl.create(:user)
 		sign_in @user
	end
	# describe "GET new" do 
	# 	it "creates a new gnar" do 
	# 		@gnar = FactoryGirl.create(:gnar)
	# 		get :new, format: 'js'
	# 	end
	# end

	describe "POST create" do
		it "finds the photo and assigns to @photo" do 
			@photo = FactoryGirl.create(:photo)
			xhr :post, :create, gnar: (FactoryGirl.build :gnar, photo: @photo).attributes.symbolize_keys 
      assigns(:photo).should eq(@photo)
		end
		it "gets all of the gnars for the photo in @gnars" do 
			@photo = FactoryGirl.create(:photo)
			xhr :post, :create, gnar: (FactoryGirl.build :gnar, photo: @photo).attributes.symbolize_keys 
			assigns(:gnars).length.should eq(1)
		end
		it "creates the gnar against the photo" do 
			@photo = FactoryGirl.create(:photo)
			expect {
				xhr :post, :create, gnar: (FactoryGirl.build :gnar, photo: @photo).attributes.symbolize_keys 
			}.to change(Gnar, :count).by(1)
		end
	end
	describe "POST delete" do 
		before :each do 
			@photo = FactoryGirl.create(:photo)
			@gnar = FactoryGirl.create(:gnar, photo: @photo)
		end
		it "finds the gnar" do
			xhr :delete, :destroy, id: @gnar
			assigns(:gnar).should eq(@gnar)
		end
		it "gets the photo of the gnar in @photo" do 
			xhr :delete, :destroy, id: @gnar
      assigns(:photo).should eq(@photo)
		end
		it "gets all of the gnars against the photo in @gnars" do 
			@gnar2 = FactoryGirl.create(:gnar, photo: @photo)
			xhr :delete, :destroy, id: @gnar
			assigns(:gnars).length.should eq(1)
		end
		it "deletes the gnar of the current user against the photo" do 
			expect{
				xhr :delete, :destroy, id: @gnar
				}.to change(Gnar, :count).by(-1)
		end
	end
end