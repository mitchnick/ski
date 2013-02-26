class MyMountainsController < ApplicationController

	def new
		@mymountain = MyMountain.new
	end

	def create 
		@mountain = Mountain.find(params[:my_mountain][:mountain_id])
		if @mountain.present?
			@mymountain = @mountain.my_mountains.build
			@mymountain.mountain_id = @mountain.id
			@mymountain.user_id = current_user.id
			@mymountain.type = params[:my_mountain][:type]
			@mymountain.save
		end
		redirect_to :back
	end

	def destroy
		@mymountain = MyMountain.find(params[:id])
		@mymountain.destroy
		redirect_to :back
	end

end
