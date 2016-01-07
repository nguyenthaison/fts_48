class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource

  def index
    @questions = @questions.page(params[:page]).per 15
  end

  def show
    @answers = @question.answers
  end

  def destroy
    if @question.destroy
      flash[:success] = t "admin.question.flash_destroy_question_success"
    else
      flash[:danger] = t "admin.question.flash_destroy_question_fail"
    end
    redirect_to :back
  end

end
