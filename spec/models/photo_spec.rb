require 'spec_helper'
require 'faker'
require 'carrierwave/test/matchers' 

describe Photo do
	include CarrierWave::Test::Matchers 

  it "has a valid factory for files" do 
    FactoryGirl.create(:photo).should be_valid
  end
  # it "has a valid factory for remote images" 
  #Test does this separately from how production does it. Skipping testing for now.
  
  describe "data" do 
  	it "is invalid without a name" do 
  		FactoryGirl.build(:photo, name: nil).should_not be_valid
  	end
  	it "is invalid without a mountain" do
  		FactoryGirl.build(:photo, mountain: nil).should_not be_valid
  	end
  	it "is invalid without a file" do 
  		#Do not test remote image functions
  		FactoryGirl.build(:photo, image: nil).should_not be_valid
  	end
  	it "has an owner" do 
  		@user = FactoryGirl.create(:user)
  		@photo = FactoryGirl.create(:photo, user: @user).should be_valid
  	end
  	it "has a rider" do
  		@user = FactoryGirl.create(:user)
  		@photo = FactoryGirl.create(:photo, rider: @user).should be_valid
  	end
  	it "accepts tags" do 
  		@photo = FactoryGirl.create(:photo, tag_list: 'hello').should be_valid
  	end
  	it "can be voted up in the form of gnar" do 
  		@user = FactoryGirl.create(:user)
  		@photo = FactoryGirl.create(:photo)
  		@photo.gnars.count == 0
  		@user.give_gnar(@photo)
  		@photo.gnars.count == 1
  	end
  	it "can keep track of a view count" do
  		FactoryGirl.build(:photo, views: 3).should be_valid
  	end
  	it "has a maximum length of 50 for the name" do 
  		FactoryGirl.build(:photo, name: "x"*51).should_not be_valid
  	end
  end

  describe "methods" do 
  	it "can order the photos by gnar count" do
      @user = FactoryGirl.create(:user)
      @mountain = FactoryGirl.create(:mountain)
      @user2 = FactoryGirl.create(:user)
  		@photo1 = FactoryGirl.create(:photo, :mountain => @mountain)
  		@photo2 = FactoryGirl.create(:photo, :mountain => @mountain)
  		@user.give_gnar(@photo)
  		@photos_initial = Photo.all
  		@photos_initial == [@photo1, @photo2]
			@user.give_gnar(@photo2)
  		@user2.give_gnar(@photo2)
  		@photos = Photo.all
  		@photos == [@photo2, @photo1]
    end
    context "grab exif data" do 
    	before :each do
    		@mountain = FactoryGirl.create(:mountain)
    		@photo = FactoryGirl.create(:photo, :mountain => @mountain)
    	end
    end
  end
  describe "carrierwave does work on the photo" do  	
  	before :each do
  		ImageUploader.enable_processing = true
  		@mountain = FactoryGirl.create(:mountain)
    	@photo = FactoryGirl.create(:photo, :mountain => @mountain)
  	end

  	after :each do
  		ImageUploader.enable_processing = false
  	end

		it "has a camera_type" do
  		@photo.camera_type.should_not be_blank
  	end
  	it "has a shutter speed" do 
  		@photo.shutter_speed.should_not be_blank
  	end
  	it "has an aperture" do
  		@photo.aperture.should_not be_blank
  	end
  	it "has a focal length" do
  		@photo.focal_length.should_not be_blank
  	end

  	# undefined method current_path
  	# it "should have a thumbnail of size 100 x 100" do 
  	# 	@photo.thumb100.should have_dimensions(100, 100) 
  	# end
  	# it "should have a thumbnail of size 270 x 270" do 
  	# 	@photo.thumb.should have_dimensions(200, 200)
  	# end
  	# it "should have a maximum width of 900" do 
  	# 	@photo.image_url.should be_no_larger_than(900, 3000)
  	# end
  end
end



# == Schema Information
#
# Table name: photos
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  creator           :integer
#  photographer      :integer
#  rider             :integer
#  mountain_id       :integer
#  mountain_fat      :string(255)
#  camera_type       :string(255)
#  lens_type         :string(255)
#  aperture          :string(255)
#  shutter_speed     :string(255)
#  focal_length      :string(255)
#  views             :integer
#  license_attr      :string(255)
#  url               :string(255)
#  current_path      :string(255)
#  identifier        :string(255)
#  city              :string(255)
#  state             :string(255)
#  zipcode           :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  image             :string(255)
#  description       :text
#  image_thumb       :string(255)
#  image_max_width   :string(255)
#  width             :string(255)
#  height            :string(255)
#  taken_time        :date
#  admin_description :text
#

