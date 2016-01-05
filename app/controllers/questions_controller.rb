class QuestionsController < ApplicationController
  def index

  end

  def new
    @subjects = Subject.all
    @question = Question.new
    @question.answers.build
  end

  def create
    @question = Question.new question_params
    if @question.save
      redirect_to user_questions_path
    else
      render :new
    end
  end

  private
  def question_params
    params.require(:question).permit :question_type, :content, :subject_id,
      :user_id, :status, answers_attributes: [:id, :is_correct, :content, :_destroy]
  end

end
