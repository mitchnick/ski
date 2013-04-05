class RegionsController < ApplicationController
	def show
		@region = Region.find(params[:id])
		@mountains = @region.mountains.paginate(page: params[:page], per_page: GlobalVar::PHOTOSPERPAGE)
  end
end