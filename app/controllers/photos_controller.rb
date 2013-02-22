class PhotosController < ApplicationController
  before_filter :get_mountain

  def get_mountain
    @mountain = Mountain.find(params[:mountain_id])
  end

  def index
    @photos = @mountain.photos
  end

  def show
    @photo = @mountain.photos.find(params[:id])
  end

  def new
  	@photo = @mountain.photos.build
  end

  def create
  	@photo = @mountain.photos.new(params[:photo])
    
  	if @photo.save
      @relationship = @photo.photo_relationships.build
      @relationship.photo_id = @photo.id
      @relationship.user_id = current_user.id
      @relationship.role_id = 0  #Creator
      if @relationship.valid? 
        @relationship.save
      end
      flash[:notice] = "Successfully added your photo"
  		redirect_to [@mountain, @photo]
  	else
  		render :action => 'new'
  	end
  end

end