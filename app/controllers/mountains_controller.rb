class MountainsController < ApplicationController
  def index
    @mountains = Mountain.all
  end

	def show
		@mountain = Mountain.find(params[:id])
  end

  def create
  	@mountain = Mountain.new
  	# TODO : Model cleanup. Nothing has been added here and it needs to be done correctly
  end
end
