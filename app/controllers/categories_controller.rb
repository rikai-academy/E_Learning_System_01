class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate(page: params[:page])
    render :home
  end
end
