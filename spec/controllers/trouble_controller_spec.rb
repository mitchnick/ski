require 'spec_helper'

describe PhotosController do
	before :each do
		@user = FactoryGirl.create(:user)
		@mountain = FactoryGirl.create(:mountain)
		@photo = FactoryGirl.create(:photo, mountain: @mountain, user: @user)
		sign_in @user
		@rider_user = FactoryGirl.create(:user)
	end

	describe "PUT add rider" do 
	end
end