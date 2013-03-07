class MyMountainsController < ApplicationController

	respond_to :html, :js
	def new
		@mymountain = MyMountain.new
	end

	def create 
		@mountain = Mountain.find(params[:my_mountain][:mountain_id])
		@mymountains = @mountain.my_mountains
		if @mountain.present?
			if @mountain.type = MyMountainRole::WANTTOGO
				current_user.wants_to_go(@mountain)
			elsif @mountain.type = MyMountainRole::HAVEBEEN
				current_user.has_been_to(@mountain)
			end
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
