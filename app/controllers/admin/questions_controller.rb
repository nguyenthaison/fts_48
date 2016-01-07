class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource

  def index
    @questions = @questions.page(params[:page]).per 15
  end

  def show
    @answers = @question.answers
  end

  def new
    @subjects = Subject.all
    @question.answers.build
  end

  def create
    if @question.update_attributes question_params
      flash[:success] = t "admin.question.flash_create_question_success"
      redirect_to admin_questions_path
    else
      flash[:error] = t "admin.question.flash_create_question_fail"
      render :new
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t "admin.question.flash_destroy_question_success"
    else
      flash[:danger] = t "admin.question.flash_destroy_question_fail"
    end
    redirect_to :back
  end

  private
  def question_params
    params.require(:question).permit :question_type, :content, :subject_id,
      :user_id, :status, answers_attributes: [:id, :is_correct, :content, :_destroy]
  end

end
