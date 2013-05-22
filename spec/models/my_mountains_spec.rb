require 'spec_helper'

describe MyMountain do
	
	it "is created via factory" do 
		FactoryGirl.create(:my_mountain, :been_here).should be_valid
	end

	it "is not created without a user" do 
		FactoryGirl.build(:my_mountain, :been_here, user: nil).should_not be_valid
	end

	it "is not created without a mountain" do
		FactoryGirl.build(:my_mountain, :been_here, mountain: nil).should_not be_valid
	end

	it "is not created without a type" do 
		FactoryGirl.build(:my_mountain, type: nil).should_not be_valid
	end

	it "only one is created per unique user, mountain, type" do 
		@user = FactoryGirl.create(:user)
		@mountain = FactoryGirl.create(:mountain)
		FactoryGirl.create(:my_mountain, :been_here, user: @user, mountain:@mountain)
		FactoryGirl.build(:my_mountain, :been_here, user: @user, mountain:@mountain).should_not be_valid
	end

	it "has many users of different types" do 
		@user = FactoryGirl.create(:user)
		@mountain = FactoryGirl.create(:mountain)
		FactoryGirl.create(:my_mountain, :been_here, user: @user, mountain:@mountain)
		FactoryGirl.build(:my_mountain, :want_to_go, user: @user, mountain:@mountain).should be_valid
	end
end
