class RelationshipsController < ApplicationController
  before_action :check_login, only: [:create, :destory]

  def create
    user = User.find_by(id: params[:followed_id])
    if user
      current_user.follow(user)
      redirect_to users_path
    else
      flash[:danger] = t("errors.not_found_user")
      redirect_to request.referer
    end
  end
  def destroy
    user = Relationship.find_by(id: params[:id]).followed
    if user 
      current_user.unfollow(user)
      redirect_to users_path
    else
      flash[:danger] = t("errors.not_found_user")
      redirect_to request.referer
    end
  end
  private
    def check_login
      unless logged_in?
        flash[:danger] = t("errors.not_login")
        redirect_to root_path
      end
    end
end
