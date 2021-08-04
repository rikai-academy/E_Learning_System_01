class CategoriesController < ApplicationController

  def home
    @categories = Category.paginate(page: params[:page], per_page: 6)
  end
end
