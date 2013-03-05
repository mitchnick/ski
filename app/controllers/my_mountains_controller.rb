class MyMountainsController < ApplicationController

	respond_to :html, :js
	def new
		@mymountain = MyMountain.new
	end

	def create 
		@mountain = Mountain.find(params[:my_mountain][:mountain_id])
		@mymountains = @mountain.my_mountains
		if @mountain.present?
			@mymountain = @mountain.my_mountains.build
			@mymountain.mountain_id = @mountain.id
			@mymountain.user_id = current_user.id
			@mymountain.type = params[:my_mountain][:type]
			@mymountain.save
		end
		respond_to do |format|
			format.html
			format.js
		end
	end

	def destroy
		@mymountain = MyMountain.find(params[:id])
		@mountain = @mymountain.mountain
		@mymountains = @mountain.my_mountains
		@mymountain.destroy
		respond_to do |format|
			format.html
			format.js
		end
	end

end
