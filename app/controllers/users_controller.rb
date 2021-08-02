class UsersController < ApplicationController
  before_action :found_user, only: [:show]
  def found_user
    @user = User.find_by(id: session[:user_id])
    if @user
      return @user
    else
      flash[:danger] = t('errors.not_login')
      redirect_to login_path
    end
  end
  def show
    
  end
  def new
    @user =User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render 'new'
    end
  end
  private
    def user_params
      params.require(:user).permit(:username, :email, :password,
                                  :password_confirmation)
    end
end
