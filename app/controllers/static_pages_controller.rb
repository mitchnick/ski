class StaticPagesController < ApplicationController
	def home
		@users = User.all
		@mountains = Mountain.all
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
