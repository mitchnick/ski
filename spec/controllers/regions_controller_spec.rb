require 'spec_helper'

describe RegionsController do

  describe "GET #show" do
    before :each do
      @region = FactoryGirl.create(:region)
    end
    it "assigns the requested region to @region" do 
      get :show, id: @region
      assigns(:region).should eq(@region)
    end
    it "renders the #show view" do 
      get :show, id: @region
      response.should render_template :show
    end
  end

end