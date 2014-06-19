require 'spec_helper'

describe UsersController do

  before (:each) do
    @user = FactoryGirl.create(:user)
  end

  describe "GET show" do
    it "should find the user and assign it to @user" do
      get :show, id: @user
      assigns(:user).should eq(@user)
    end
    it "should get the photos the user uploaded and assign it to @photos" do
      @photo = FactoryGirl.create(:photo, user: @user)
      get :show, id: @user
      assigns(:photos).should eq([@photo])
    end
    it "should get the photos the user has gave gnar too and assign it to @gnar_photos" do
      @photo = FactoryGirl.create(:photo)
      @gnar = FactoryGirl.create(:gnar, photo: @photo, user: @user)
      get :show, id: @user
      assigns(:gnar_photos).should eq([@photo])
    end
    it "should get the mountains the user has been to and assign it to @have_been" do
      @photo = FactoryGirl.create(:photo)
      @mymountain = FactoryGirl.create(:my_mountain, :been_here, user: @user)
      get :show, id: @user
      assigns(:have_been).should eq([@mymountain])
    end
    it "should get the mountains the user wants to go to and assign it to @want_to" do
      @photo = FactoryGirl.create(:photo)
      @mymountain = FactoryGirl.create(:my_mountain, :want_to_go, user: @user)
      get :show, id: @user
      assigns(:want_to).should eq([@mymountain])
    end
    it "should assign the home mountain to @home_mountain if the user has assigned one" do
      @mountain = FactoryGirl.create(:mountain)
      @user2 = FactoryGirl.create(:user, mountain_id: @mountain.id)
      get :show, id: @user2
      assigns(:home_mountain).should eq(@mountain)
    end
    it "should render the #show view" do
      get :show, id: @user
      response.should render_template :show
    end
  end

  describe "GET edit" do
    it "finds the correct user" do
      sign_in @user
      get :edit, id: @user
      assigns(:user).should eq(@user)
    end
    it "makes sure the user is signed in" do
      get :edit, id: @user
      flash[:error].should_not be_nil
      response.should redirect_to @user
    end
    it "renders the #edit view" do
      sign_in @user
      get :edit, id: @user
      response.should render_template("edit")
    end
  end

  describe "PUT update" do
    context "correct attributes" do
      it "gets the correct user" do
        put :update, id: @user, user: (FactoryGirl.build :user).attributes.symbolize_keys
        assigns(:user).should eq(@user)
      end
      it "updates the user" do
        sign_in @user
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "Mitch Nick")
        @user.reload
        @user.name.should eq("Mitch Nick")
      end
      it "shows a flash message" do
        put :update, id: @user, user: (FactoryGirl.build :user).attributes.symbolize_keys
        flash[:error].should_not be_nil
      end
      it "redirects the user to the @user page" do
        put :update, id: @user, user: (FactoryGirl.build :user).attributes.symbolize_keys
        response.should redirect_to @user
      end
    end
    context "incorrect attributes" do
      it "does not change the @user attributes" do
        sign_in @user
        @name = @user.name
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "Mitch Nick", email: nil)
        @user.name.should_not eq("Mitch Nick")
        @user.name.should eq(@name)
      end
      it "re-renders the edit screen" do
        sign_in @user
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: nil)
        response.should render_template("edit")
      end
    end
  end

  # describe "GET new" do
  #   it "assigns a new user to @user" do
  #     get :new
  #     assigns(:user).should_not be_nil
  #   end
  #   it "renders the #new template" do
  #     get :new
  #     response.should render_template("new")
  #   end
  # end
end