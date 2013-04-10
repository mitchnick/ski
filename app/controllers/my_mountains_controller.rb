class MyMountainsController < ApplicationController
	before_filter :authenticate_user!

	respond_to :html, :js
	def new
		@mymountain = MyMountain.new
	end

	def create 
		@mountain = Mountain.find_by_id(params[:my_mountain][:mountain_id])
		role_type = params[:my_mountain][:role_type].to_i
		@mymountains = @mountain.my_mountains
		if @mountain.present?
			if role_type == MyMountainRole::WANTTOGO
				current_user.wants_to_go(@mountain)
			elsif role_type == MyMountainRole::HAVEBEEN
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
