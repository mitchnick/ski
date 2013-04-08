class StaticPagesController < ApplicationController

	def home
		@landing_page = true
		@no_footer = true
		@mountains = Mountain.all
		# Photo for landing page background to be a top 10 most viewed photo
		@photos = Photo.order("views DESC").limit(10)
		@photo = @photos[Random.rand(10)]
		@photo_user = PhotoRelationship.where("role_id AND photo_id", RelationshipRole::CREATOR, @photo.id).first.user
	end

	def search
		@mountains = Mountain.search(params[:search]).sort_by{|mountain| [mountain.region.name, mountain.name] }
		@regions = Region.search(params[:search])
		@search_results = @mountains + @regions
		if @search_results.length == 1 and @mountains.length == 1 then 
			redirect_to @mountains.first
		elsif @search_results.length == 1 and @regions.length == 1 then 
			redirect_to @regions.first
		end
	end

	def about
	end

	def contact
	end

end
