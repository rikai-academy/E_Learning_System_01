class SummariesController < ApplicationController
  def create
    @summary = current_user.summaries.new(summary_params)
    @summary.status = true
    if @summary.save
      flash[:success] = "Summary created!"
      redirect_to home_path
    else
      flash[:danger] = "Content can't be empty "
      redirect_to home_path
    end 
  end
  def unactive
    if Summary.find_by(id: params[:id]).update(status: false)
      flash[:success] = "Successful"
      redirect_to home_path
    else
      flash[:danger] = "Not successful"
      redirect_to home_path
    end
  end
  private
    def summary_params
      params.permit(:content)
    end
end
