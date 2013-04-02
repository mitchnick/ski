class ViewsController < ApplicationController
	before_filter :authenticate_user!
	
	def new
		@view = View.new
	end
end
