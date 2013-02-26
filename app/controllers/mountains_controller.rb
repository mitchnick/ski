class MountainsController < ApplicationController
  before_filter :get_mountain

  def get_mountain
    @mountain = Mountain.find(params[:id])
  end

  def index
    @mountains = Mountain.all
  end

	def show
		# @mountain = Mountain.find(params[:id])
    @mymountains = @mountain.my_mountains
  end

  def create
  	@mountain = Mountain.new
  	# TODO : Model cleanup. Nothing has been added here and it needs to be done correctly
  end
end
