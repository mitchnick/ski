class PhotoRelationshipsController < ApplicationController
	respond_to :html, :js	
	before_filter :authenticate_user!

	def new
		@relationship = PhotoRelationship.new
	end
	
	def create
		@relationship = PhotoRelationship.new(params[:photo][:mountain])
		# logger.warn("======#{@relationship.inspect}======")
	end	
end