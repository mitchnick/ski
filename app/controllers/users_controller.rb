class UsersController < ApplicationController
  before_filter :correct_user, only: [:update, :edit]

  # def new
  #   @user = User.new
  # end

  def create
  	@user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Welcome to Where to Ski!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @photos = @user.photos.sort { |x,y| y.gnars.count <=> x.gnars.count }.paginate(page: params[:page], per_page: GlobalVar::PHOTOSPERPAGE)
    @gnar_photos = @user.gnar_photos.paginate(page: params[:page], per_page: GlobalVar::PHOTOSPERPAGE)
    @have_been = @user.my_mountains.where("type = ?", MyMountainRole::HAVEBEEN).paginate(page: params[:page], per_page: GlobalVar::PHOTOSPERPAGE)
    @want_to = @user.my_mountains.where("type = ?", MyMountainRole::WANTTOGO).paginate(page: params[:page], per_page: GlobalVar::PHOTOSPERPAGE)
    if @user.mountain_id? then @home_mountain = Mountain.find(@user.mountain_id) end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User updated"
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
      flash[:notice] = "Password successfully updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  private
    def correct_user
      @user = User.find(params[:id])
      unless @user == current_user then
        flash[:error] = "Hey, you aren't this person! You can only edit your own User record."
        redirect_to @user
      end
    end
end
