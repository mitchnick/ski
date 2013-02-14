class PhotoRelationshipsController < ApplicationController
	respond_to :html, :js	

	def new
		@relationship = PhotoRelationship.new
	end
	
	def create
		@relationship = PhotoRelationship.new(params[:photo][:mountain])
		@photo.create_photo_relationship()
		# @relationship.user_id = current_user
		# @relationship.photo_id = @photo.id
		# @relationship.role_id = 0
	end	
end