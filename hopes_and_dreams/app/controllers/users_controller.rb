class UsersController < ApplicationController

  before_action :require_logged_in, except: [:new, :create]
  
  def new
    @user = User.new
    render :new
  end

    #We are signing up a user
  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
