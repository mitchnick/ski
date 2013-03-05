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
      @relationship = @photo.photo_relationships.build
      @relationship.photo_id = @photo.id
      @relationship.user_id = current_user.id
      @relationship.role_id = 0  #Creator
      if @relationship.valid? 
        @relationship.save
      end
      @mymountain = @mountain.my_mountains.build
      @mymountain.mountain_id = @mountain.id
      @mymountain.user_id = current_user.id
      @mymountain.type = 1  #I've Been
      if @mymountain.valid?
        @mymountain.save
      end
      
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
      redirect_to [@mountain, @photo]
    else
      render 'edit'
    end
  end

end