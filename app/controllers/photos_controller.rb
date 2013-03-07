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
    @gnars = @photo.gnars
  end

  def new
  	@photo = @mountain.photos.build
  end

  def create
  	@photo = @mountain.photos.new(params[:photo])
    
  	if @photo.save
      current_user.create_relationship(@photo, RelationshipRole::CREATOR)
      current_user.has_been_to(@mountain)
      flash[:notice] = "Successfully added your photo"
  		redirect_to [@mountain, @photo]
  	else
  		render :action => 'new'
  	end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = @mountain.photos.find(params[:id])
    if @photo.update_attributes(params[:photo])
      flash[:success] = "Photo updated"
      @mountain = Mountain.find(params[:photo][:mountain_id])
      redirect_to [@mountain, @photo]
    else
      render 'edit'
    end
  end

end