class GnarsController < ApplicationController
	before_filter :authenticate_user!

	respond_to :html, :js
	# def new
	# 	@gnar = Gnar.new
	# end

	def create 
		@photo = Photo.find(params[:gnar][:photo_id])
		@gnars = @photo.gnars
		if @photo.present?
			current_user.give_gnar(@photo)
		end
		respond_to do |format|
			format.html
			format.js
		end
	end

	def destroy		
		@gnar = Gnar.find(params[:id])
		@photo = @gnar.photo
		@gnars = @gnar.photo.gnars
		current_user.take_back_gnar(@gnar)
		respond_to do |format|
			format.html
			format.js
		end
	end
end