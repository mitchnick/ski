class PhotoRelationshipsController < ApplicationController
	respond_to :html, :js	

	def new
		@relationship = PhotoRelationship.new
	end
	
	def create
		@relationship = PhotoRelationship.new(params[:photo][:mountain])
		# logger.warn("======#{@relationship.inspect}======")
	end	
end