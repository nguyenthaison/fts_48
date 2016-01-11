class Admin::ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exams = @exams.page(params[:page]).per 10
  end

  def update
    if @exam.update_attributes exam_params
      flash[:success] = t "exams.update.success"
    else
      flash[:error] = t "exams.update.error"
    end
    redirect_to admin_exams_path
  end

  def destroy
    if @exam.destroy
      flash[:success] = t "admin.exam.flash_destroy_exam_success"
    else
      flash[:error] = t "admin.exam.flash_destroy_exam_fail"
    end
    redirect_to admin_exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :status
  end
end
