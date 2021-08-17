class LessonsController < ApplicationController
  before_action :found_lesson, only: [:test, :result_test, :show]
  def show
    @words = @lesson.content_lessons
  end
  def test
    @questions = @lesson.questions
  end
  def get_user_answer(questions)
    @ans_user = Hash.new
    questions.each do |ans|
      if params["ques#{ans.id}"].nil?
        @ans_user[ans.id.to_s] = nil
      else
        @ans_user[ans.id.to_s] = params["ques#{ans.id}"]
      end
    end
    return @ans_user
  end
  def result_test
    session.delete(:ans_user)
    @questions = @lesson.questions.all
    @dem = 0   
    @ans_user = get_user_answer(@questions)
    not_choose = t("lesson.test.not_choose_ans")
    @questions.each do |q|
        @ans = q.answers.right_answer.first  
        if params["ques#{q.id}"].nil?
          not_choose += "#{@questions.index(q) + 1 } "
        else
          if @ans.content == params["ques#{q.id}"]
            @dem +=1
          end
        end
      end 
    if not_choose == t("lesson.test.not_choose_ans")     
      flash[:success] = "#{@dem}/#{@questions.count}"
      return @ans_user && @questions
    else
      session[:ans_user] = @ans_user     
      flash[:danger] = not_choose
      redirect_to request.referer
    end      
  end
  private
    def found_lesson
      @lesson = Lesson.find_by(id: params[:id])
      return @lesson unless @lesson.nil?
      flash[:danger] = t("lesson.show.not_found")
      redirect_to home_path
    end
end
