class RegionsController < ApplicationController
	def show
		@region = Region.find(params[:id])
		@mountains = @region.mountains
  end
end