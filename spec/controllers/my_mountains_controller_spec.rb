require 'spec_helper'

describe MyMountainsController do
	before :each do
 		@user = FactoryGirl.create(:user)
 		sign_in @user
	end

	describe "POST create" do 
		before :each do 
			@mountain = FactoryGirl.create(:mountain)
		end
		it "finds the correct mountain" do 
			xhr :post, :create, my_mountain: (FactoryGirl.build :my_mountain, :been_here, mountain: @mountain).attributes.symbolize_keys 
      assigns(:mountain).should eq(@mountain)
		end
		it "gets all of the mymountains against the mountain" do 
			@my_mountain2 = FactoryGirl.create(:my_mountain, :want_to_go, mountain: @mountain)
			xhr :post, :create, my_mountain: (FactoryGirl.build :my_mountain, :been_here, mountain: @mountain).attributes.symbolize_keys 
			assigns(:mymountains).length.should eq(2)
		end
		it "assigns want to go to mymountain if selected" do 
			expect {
				xhr :post, :create, my_mountain: (FactoryGirl.build :my_mountain, :want_to_go, mountain: @mountain).attributes.symbolize_keys 
			}.to change(MyMountain, :count).by(1)
		end
		it "assigns have been to mymountain if selected" do 
			expect {
				xhr :post, :create, my_mountain: (FactoryGirl.build :my_mountain, :been_here, mountain: @mountain).attributes.symbolize_keys 
			}.to change(MyMountain, :count).by(1)
		end
	end
	describe "POST delete" do 
		before :each do
			@mountain = FactoryGirl.create(:mountain)
			@my_mountain = FactoryGirl.create(:my_mountain, :been_here, mountain: @mountain)
		end
		it "finds the correct my_mountain" do 
			xhr :post, :destroy, id: @my_mountain
			assigns(:mymountain).should eq(@my_mountain)
		end
		it "grabs the correct mountain" do 
			xhr :post, :destroy, id: @my_mountain
			assigns(:mountain).should eq(@mountain)
		end
		it "gets all of the my_mountains" do 
			@my_mountain2 = FactoryGirl.create(:my_mountain, :want_to_go, mountain: @mountain)
			xhr :post, :destroy, id: @my_mountain
			assigns(:mymountains).should eq([@my_mountain2])
		end
		it "deletes the my_mountain record" do 
			expect{
				xhr :post, :destroy, id: @my_mountain
				}.to change(MyMountain, :count).by(-1)
		end
	end
end