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

  def show
    @exam.change_status_after_start
  end

  def update
    @exam.calculate_time
    @exam.status = :unchecked if params[:commit] == "Finish"
    if @exam.update_attributes exam_params
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :duration, :number_of_question, :status,
    :user_id, :subject_id, :spent_time, results_attributes: [:id, :answer_id, :content]
  end
end
