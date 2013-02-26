class GnarsController < ApplicationController
	before_filter :signed_in
	# TODO: Model --- Make sure the user is signed in to do this, find right devise code

	respond_to :html, :js
	def new
		@gnar = Gnar.new
	end

	def create 
		@photo = Photo.find(params[:gnar][:photo_id])
		if @photo.present?
			@gnar = @photo.gnars.build
			@gnar.photo_id = @photo.id
			@gnar.user_id = current_user.id
			@gnar.save
		end
		redirect_to :back
	end

	def destroy		
		@gnar = Gnar.find(params[:id])
		@gnar.destroy 
		redirect_to :back
	end

	private
		def signed_in
			# TODO: Add a place to ensure user is signed in
			# @gnar = @photo.gnars.find_by_user_id(current_user.id)
		end

end