class GnarsController < ApplicationController
	before_filter :signed_in
	# TODO: Model --- Make sure the user is signed in to do this, find right devise code

	respond_to :html, :js
	def new
		@gnar = Gnar.new
	end

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
		# redirect_to :back
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

	private
		def signed_in
			# TODO: Add a place to ensure user is signed in
			# @gnar = @photo.gnars.find_by_user_id(current_user.id)
		end

end