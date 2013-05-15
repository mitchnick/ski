require 'spec_helper'

describe Mountain do
  
  it "has a valid factory" do 
    FactoryGirl.create(:mountain).should be_valid
  end

  describe "data" do
  	it "is invalid without a name" do
  		FactoryGirl.build(:mountain, name: nil, slug: "foo").should_not be_valid
  	end
  	it "has a unique slug" do
  		FactoryGirl.create(:mountain, slug: 'mountain1')
  		FactoryGirl.build(:mountain, slug: 'mountain1').should_not be_valid
  	end
  	it "has a region it belongs to" do 
  		@region = FactoryGirl.create(:region)
  		FactoryGirl.create(:mountain, region: @region)
  	end
  	it "has many photos" do
			@mountain = FactoryGirl.create(:mountain)
  		@photo1 = FactoryGirl.create(:photo, mountain: @mountain)
  		@photo2 = FactoryGirl.create(:photo, mountain: @mountain)
  		@mountain.photos.count.should == 2
  	end
  	it "has many photographers" do 
			@user1 = FactoryGirl.create(:user)
			@user2 = FactoryGirl.create(:user)
			@mountain = FactoryGirl.create(:mountain)
  		@photo1 = FactoryGirl.create(:photo, mountain: @mountain, user: @user1)
  		@photo2 = FactoryGirl.create(:photo, mountain: @mountain, user: @user2)
  		@mountain.photographers.count.should == 2
  	end
  	it "has many riders" do
			@user1 = FactoryGirl.create(:user)
			@user2 = FactoryGirl.create(:user)
			@mountain = FactoryGirl.create(:mountain)
  		@photo1 = FactoryGirl.create(:photo, mountain: @mountain, rider: @user1)
  		@photo2 = FactoryGirl.create(:photo, mountain: @mountain, rider: @user2)
  		@mountain.riders.count.should == 2
  	end
  end
  describe "methods" do
  	it "has a top image" do 

  	end
  	it "can be searched for" do
		 	@mountain1 = FactoryGirl.create(:mountain, name: "North Mountain")
		 	@mountain2 = FactoryGirl.create(:mountain, name: "East Mountain")
		 	Mountain.search("Nor").count.should == 1
		 	Mountain.search("Mountain").count.should == 2
		 	Mountain.search("West").count.should == 0
		end

	  it "can search regardless of capitalization" do
	  	@mountain1 = FactoryGirl.create(:mountain, name: "nOrTh")
	  	Mountain.search("NORTH").count.should == 1
	  	Mountain.search("noRTH").count.should == 1
	  	Mountain.search("NORth").count.should == 1
	  end
  end

end


# == Schema Information
#
# Table name: mountains
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  gps_lat      :string(255)
#  gps_lon      :string(255)
#  description  :text
#  phone        :string(255)
#  web_link     :string(255)
#  tickets_link :string(255)
#  trail_map    :string(255)
#  region       :string(255)
#  state        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#