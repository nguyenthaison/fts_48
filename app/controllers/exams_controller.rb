class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exam = Exam.new
    @subjects = Subject.all
    @exams = current_user.exams
  end

  def create
    if @exam.save
      flash[:success] = t ".success"
      redirect_to exams_path
    else
      flash[:danger] = t ".error"
    end
  end

  private
  def exam_params
    params.require(:exam).permit :duration, :number_of_question,
      :status, :user_id, :subject_id
  end
end
