class ViewCountsController < ApplicationController
	before_filter :authenticate_user!
	
	def new
		@view = ViewCount.new
	end
end
