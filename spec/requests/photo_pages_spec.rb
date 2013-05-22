require 'spec_helper'

describe "Photo pages" do
	let(:user) { FactoryGirl.create(:user)}
	let(:region) { FactoryGirl.create(:region)}
	let(:mountain) {FactoryGirl.create(:mountain)}
	let(:photo) {FactoryGirl.create(:photo, mountain: mountain)}

	# Testing view count as an integration test as it involves IP address information
	describe "Test FactoryGirl creates records correctly" do 
		describe "visit mountain path" do
			it "can be visited after FactoryGirl create" do
				visit mountain_path(mountain)
				page.should have_selector('h1', text: "Breck Test")
			end
			it "has the correct region associated to it" do
				visit mountain_path(mountain)
				page.should have_selector('h4', text: "Rockies")
			end
		end

		describe "visit photo path" do
			it "Photo can be visited after FactoryGirl create records" do
				visit mountain_photo_path(mountain, photo) 
				page.should have_selector('title', text: photo.name)
			end
		end
	end

	describe "visiting the photo page when signed in" do
		it "increased the view count the first day of the view" do 
			sign_in user
			ViewCount.count.should equal(0)
			visit mountain_photo_path(mountain, photo) 
    	photo.view_counts.count.should equal(1)
		end
		it "does not increase the view count on the second view of the day" do 
			sign_in user
			visit root_path
			ViewCount.count.should equal(0)
			visit mountain_photo_path(mountain, photo) 
			visit root_path
			visit mountain_photo_path(mountain, photo) 
			photo.view_counts.count.should equal(1)
		end
		it "increased the view count by 2 if viewed unsigned in and then signed in" do
			visit root_path
			ViewCount.count.should equal(0)
			visit mountain_photo_path(mountain, photo) 
			visit root_path
			visit mountain_photo_path(mountain, photo) 
			photo.view_counts.count.should equal(1)
			visit root_path
			sign_in user
			visit mountain_photo_path(mountain, photo)
			photo.view_counts.count.should equal(2)
		end
		it "increases the view count on the second day of viewing" do 
			sign_in user
			visit root_path
			ViewCount.count.should equal(0)
			visit mountain_photo_path(mountain, photo) 
			photo.view_counts.count.should equal(1)
			visit root_path
			Timecop.freeze(Date.today + 1) do 
				visit mountain_photo_path(mountain, photo) 
			end
			photo.view_counts.count.should equal(2)
		end
	end
	describe "visiting the photo page when not signed in" do
		it "increased the view count the first day of the view" do 
			ViewCount.count.should equal(0)
			visit mountain_photo_path(mountain, photo) 
    	photo.view_counts.count.should equal(1)
		end
		it "does not increase the view count on the second view of the day" do 
			visit root_path
			ViewCount.count.should equal(0)
			visit mountain_photo_path(mountain, photo) 
			visit root_path
			visit mountain_photo_path(mountain, photo) 
			photo.view_counts.count.should equal(1)
		end
	end
end