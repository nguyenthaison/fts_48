class Admin::ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exams = @exams.page(params[:page]).per 10
  end

  def destroy
    if @exam.destroy
      flash[:success] = t "admin.exam.flash_destroy_exam_success"
    else
      flash[:error] = t "admin.exam.flash_destroy_exam_fail"
    end
    redirect_to admin_exams_path
  end

end
