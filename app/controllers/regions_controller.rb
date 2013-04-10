class RegionsController < ApplicationController
	def show
		@region = Region.find_by_slug!(params[:id])
		@mountains = @region.mountains.paginate(page: params[:page], per_page: GlobalVar::PHOTOSPERPAGE)
  end
end