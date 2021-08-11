class UsersController < ApplicationController
  before_action :found_user, only: [:show]
  
  def show  
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to home_path
    else
      render :new
    end
  end
  private
    def user_params
      params.require(:user).permit(:username, :email, :password,
                                  :password_confirmation)
    end
    def found_user
      @user = User.find_by(id: session[:user_id])
      return @user unless @user.nil?
      flash[:danger] = t("errors.not_login")
      redirect_to root_path
  end
end