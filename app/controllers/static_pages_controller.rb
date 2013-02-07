class StaticPagesController < ApplicationController
	def home
		@users = User.all
		@mountains = Mountain.all
	end

	def about
	end

	def contact
	end
end
