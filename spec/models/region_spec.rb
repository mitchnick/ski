require 'spec_helper'
require 'faker'

describe Region do

  it "has a valid factory" do 
    FactoryGirl.create(:region).should be_valid
  end

  it "has a unique slug" do 
  	FactoryGirl.create(:region, slug: 'region1')
  	FactoryGirl.build(:region, slug: 'region1').should_not be_valid
  end

  it "has many mountains" do 
  	@region = FactoryGirl.create(:region)
  	@mountain1 = FactoryGirl.create(:mountain, :region => @region)
  	@mountain2 = FactoryGirl.create(:mountain, :region => @region)
  	@region.mountains.count.should == 2
  end

  it "orders multiple regions by name" do 
  	@region1 = FactoryGirl.create(:region, name: "North")
  	@region2 = FactoryGirl.create(:region, name: "East")
  	@regions = Region.all
  	@regions = [@region2, @region1]
  end

  it "orders multiple mountains under the region by name" do 
  	@region = FactoryGirl.create(:region)
  	@mountain1 = FactoryGirl.create(:mountain, name: "Xmount")
  	@mountain2 = FactoryGirl.create(:mountain, name: "Bmount")
  	@mountains = @region.mountains
  	@mountains = [@region2, @region1]
  end

  it "can be searched for" do
  	@region1 = FactoryGirl.create(:region, name: "North Region")
  	@region2 = FactoryGirl.create(:region, name: "East Region")
  	Region.search("Nor").count.should == 1
  	Region.search("Region").count.should == 2
  	Region.search("West").count.should == 0
  end

  it "can search regardless of capitalization" do
  	@region1 = FactoryGirl.create(:region, name: "nOrTh")
  	Region.search("NORTH").count.should == 1
  	Region.search("noRTH").count.should == 1
  	Region.search("NORth").count.should == 1
  end

end