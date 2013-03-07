class UsersController < ApplicationController
  def new
    @user = User.new 
  end

  def create
  	@user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to Where to Ski!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @photos = @user.relationship_photos.sort { |x,y| y.gnars.count <=> x.gnars.count }.paginate(page: params[:page], per_page: GlobalVar::PHOTOSPERPAGE)
    @gnars = @user.gnars.paginate(page: params[:page], per_page: GlobalVar::PHOTOSPERPAGE)
    @have_been = @user.my_mountains.where("type = ?", MyMountainRole::HAVEBEEN)
    @want_to = @user.my_mountains.where("type = ?", MyMountainRole::WANTTOGO)
    if @user.mountain_id? then @home_mountain = Mountain.find(@user.mountain_id) end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "User updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(params[:user])
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      flash[:success] = "Password successfully updated"
      redirect_to @user
    else
      render "edit"
    end
  end
end
