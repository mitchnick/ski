class UsersController < ApplicationController
  def new
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
end
