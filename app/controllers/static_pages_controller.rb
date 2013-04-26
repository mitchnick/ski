class StaticPagesController < ApplicationController

	def home
		@mountains = Mountain.all
		@photos_array = Photo.all.sort { |x,y| y.gnars.count <=> x.gnars.count }
		if current_user.present? then 
			@landing_page = false
			@photos = @photos_array.paginate(page: params[:page], per_page: GlobalVar::PHOTOSPERPAGE)
		# Photo for landing page background to be a top 10 most viewed photo
		else
			@landing_page = true
			@no_footer = true
			@photo = @photos_array[Random.rand([10, @photos_array.length].min)]
			@photo_user = @photo.user
		end

	end

	def search
		@mountains = Mountain.search(params[:search]).sort_by{|mountain| [mountain.region.name, mountain.name] }.paginate(page: params[:page], per_page: GlobalVar::PHOTOSPERPAGE)
		@regions = Region.search(params[:search]).paginate(page: params[:page], per_page: GlobalVar::PHOTOSPERPAGE)
		@search_results = @mountains + @regions
		if @search_results.length == 1 and @mountains.length == 1 then 
			redirect_to @mountains.first
		elsif @search_results.length == 1 and @regions.length == 1 then 
			redirect_to @regions.first
		end
	end

	def all_mountains
		@regions = Region.all
	end

	def about
	end

	def contact
	end

end
