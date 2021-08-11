class SummariesController < ApplicationController
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
    def summary_params
      params.require(:summary).permit(:content)
    end
end
