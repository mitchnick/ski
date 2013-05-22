require 'spec_helper'

describe MountainsController do

  before :each do
    @user = FactoryGirl.create(:user)
    @mountain = FactoryGirl.create(:mountain)
  end

  describe "GET #show" do
    
    it "assigns the requested mountain to @mountain" do 
      get :show, id: @mountain
      assigns(:mountain).should eq(@mountain)
    end
    it "assigns who has been here or wants to go here to @mymountains" do 
      @been_here = FactoryGirl.create(:my_mountain, :been_here, mountain: @mountain, user: @user)
      @want_to_go = FactoryGirl.create(:my_mountain, :want_to_go, mountain: @mountain, user: @user)
      get :show, id: @mountain
      assigns(:mymountains).should eq([@been_here, @want_to_go])
    end
    it "gets the photos assigned to the mountain in @photos" do 
      @photo = FactoryGirl.create(:photo, user: @user, mountain: @mountain)
      get :show, id: @mountain
      assigns(:photos).should eq([@photo])
    end
    it "assigns who has photographed stuff here to @shoots" do 
      @photo = FactoryGirl.create(:photo, user: @user, mountain: @mountain)
      get :show, id: @mountain
      assigns(:shoots).should eq([@user])
    end
    it "assigns who has been tagged as a rider to @rides" do 
      @photo = FactoryGirl.create(:photo, rider: @user, mountain: @mountain)
      get :show, id: @mountain
      assigns(:rides).should eq([@user])
    end
    it "renders the #show view" do 
      get :show, id: @mountain
      response.should render_template :show
    end 
  end

  # Don't use the index functionality
  # describe "GET #index" do 
  #   it "populates an array of mountains" do 
  #     get :index, id: @mountain
  #     assigns(:mountains).should eq([@mountain])
  #   end
  #   it "renders the :index view" do 
  #     get :index
  #     response.should render_template :index
  #   end
  # end

end