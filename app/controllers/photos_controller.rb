class PhotosController < ApplicationController
  before_filter :get_mountain
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :add_rider, :remove_rider]
  before_filter :correct_user, only: [:edit, :update, :destroy, :add_rider, :remove_rider]

  def get_mountain
    @mountain = Mountain.find_by_slug!(params[:mountain_id])
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
      flash[:notice] = "Hey, you did it! Your photo is now live on Where To Ski. Click #{ view_context.link_to( "here", new_mountain_photo_path(@mountain))} to add another photo.".html_safe
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

  private
    def correct_user
      @photo = @mountain.photos.find(params[:id]) || @photo = Photo.find(params[:photo_id])
      @user = @photo.user
      unless @user == current_user then 
        flash[:notice] = "Hey, you can only update photos for which you are the original creator"
        redirect_to [@mountain, @photo]
      end
    end
end