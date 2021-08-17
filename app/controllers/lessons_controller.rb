class LessonsController < ApplicationController
  def show 
    @lesson = Lesson.find_by(id: params[:id])
    if @lesson
      @words = @lesson.content_lessons
    else
      flash[:danger] = t("lesson.show.not_found")
      redirect_to home_path
    end
  end
end
