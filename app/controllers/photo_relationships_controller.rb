class PhotoRelationshipsController < ApplicationController
	respond_to :html, :js	
	before_filter :authenticate_user!

	def new
		@relationship = PhotoRelationship.new
	end
	
	def create
		@photo = Photo.find_by_id(params[:photo_relationship][:photo_id])
		@role = params[:photo_relationship][:role_id]
		@user = User.find(params[:photo_relationship][:user_id])
		@user.create_relationship(@photo, @role)
		respond_to do |format|
			format.html
			format.js
		end
	end	

	def destroy 
		@relationship = PhotoRelationship.find(params[:id])
		@relationship.destroy
		respond_to do |format|
			format.html
			format.js
		end	
	end
end