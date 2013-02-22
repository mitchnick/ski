class GnarsController < ApplicationController
	# before_filter :signed_in   
	# TODO: Model --- Make sure the user is signed in to do this, find right devise code

	respond_to :html, :js
	def new
		@gnar = Gnar.new
	end

	def create 
		@gnar = Gnar.new(params[:gnar])
		@gnar.user_id = current_user.id
	end

	def destroy
		# TODO fill me in later
	end

end