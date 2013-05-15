require 'spec_helper'

describe Gnar do
  before :each do
		@photo = FactoryGirl.create(:photo)
  	@user = FactoryGirl.create(:user)
  end
  it "is created via factories" do 
  	FactoryGirl.create(:gnar, photo: @photo, user: @user)
  end
  it "is not valid without a photo" do 
  	FactoryGirl.build(:gnar, photo: nil, user: @user).should_not be_valid
  end
  it "is not valid without a user" do 
  	FactoryGirl.build(:gnar, photo: @photo, user: nil).should_not be_valid
  end
  it "is not valid when user and photo are not unique" do 
  	FactoryGirl.create(:gnar, photo: @photo, user: @user)
  	FactoryGirl.build(:gnar, photo: @photo, user: @user).should_not be_valid
  end
end
