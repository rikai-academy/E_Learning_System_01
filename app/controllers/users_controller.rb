class UsersController < ApplicationController
  def show
      @user = User.find_by(id: params[:id])
    if @user
      return @user
    else
      flash[:danger] = t("errors.not_login")
      redirect_to signup_path
    end
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end
  private
    def user_params
      params.require(:user).permit(:username, :email, :password,
                                  :password_confirmation)
    end
end
