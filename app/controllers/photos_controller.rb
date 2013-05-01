class PhotosController < ApplicationController
  before_filter :get_mountain
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def get_mountain
    @mountain = Mountain.find_by_slug!(params[:mountain_id])
  end

  def index
    @photos = @mountain.photos
  end

  def show
    @photo = @mountain.photos.find(params[:id])
    @gnars = @photo.gnars
    @photo.view_count_update(current_user, request.remote_ip)
  end

  def new
  	@photo = @mountain.photos.build
    @user = current_user.id
  end

  def create
  	@photo = @mountain.photos.new(params[:photo])
    
  	if @photo.save
      current_user.create_relationship(@photo, RelationshipRole::CREATOR)
      current_user.create_relationship(@photo, RelationshipRole::PHOTOGRAPHER)
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
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      flash[:notice] = "Photo updated"
      @mountain = Mountain.find_by_id(params[:photo][:mountain_id])
      respond_to do |format|
        format.html {redirect_to [@mountain, @photo]}
        format.js
      end
    else
      render 'edit'
    end
    
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to @mountain
  end

  def add_rider
    @photo = Photo.find(params[:photo_id])
    @photo.rider_id = params[:photo][:rider_id]
    @photo.save
    respond_to do |format|
      format.html
      format.js
    end
  end

  def remove_rider
    @photo = Photo.find(params[:photo_id])
    @photo.rider = nil
    @photo.save
    respond_to do |format|
      format.html
      format.js
    end
  end

end