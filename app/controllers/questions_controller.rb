class QuestionsController < ApplicationController
  load_and_authorize_resource

  def show
    @answers = @question.answers
  end

  def index
    @questions = current_user.questions
  end

  def new
    @subjects = Subject.all
    @question.answers.build
  end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = t "questions.flash.success"
      redirect_to user_questions_path
    else
      flash[:error] = t "questions.flash.create_fail"
      render :new
    end
  end

  def edit
    @subjects = Subject.all
    @question.answers.build
  end

  def update
    if @question&.update_attributes(question_params)
      flash[:success] = t ".success"
      redirect_to user_questions_path current_user
    else
      flash[:danger] = t ".error"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t ".success"
    else
      flash.now[:danger] = t ".error"
    end
    redirect_to user_questions_path
  end

  private
  def question_params
    params.require(:question).permit :question_type, :content, :subject_id,
      :user_id, :status, answers_attributes: [:id, :is_correct, :content, :_destroy]
  end

end
