class SummariesController < ApplicationController
  before_action :check_login, only: [:word_summary, :create]
  def create
    @summary = current_user.summaries.new(summary_params)
    @summary.status = true
    if @summary.save
      flash[:success] = t("inform.created")
      redirect_to home_path
    else     
      redirect_to home_path
    end 
  end
  def word_summary
    @words = ContentLesson.find_by(id: params[:id])
    if @words
      @content = @words.word + t("summary.mean_to") + @words.mean
      @summary = current_user.summaries.new(content: @content, status: true)
      if @summary.save
        flash[:success] = t("inform.success")
        redirect_to request.referer
      else
        flash[:danger] = flash_errors(@summary)
        redirect_to request.referer
      end        
    else
      flash[:danger] = t("inform.word_not_found")
      redirect_to request.referer
    end
  end
  def destroy
    if Summary.find_by(id: params[:id]).update(status: false)
      flash[:success] = t("inform.success")
      redirect_to home_path
    else
      flash[:danger] = t("inform.unsuccess")
      redirect_to home_path
    end
  end
  private
    def check_login
      unless logged_in?
        flash[:danger] = t("errors.not_login")
        redirect_to root_path
      end
    end
    def summary_params
      params.require(:summary).permit(:content)
    end
end
