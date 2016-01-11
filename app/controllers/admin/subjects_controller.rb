class Admin::SubjectsController < ApplicationController
  load_and_authorize_resource

  def index
    @subjects = @subjects.page params[:page]
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "admin.subject.flash_update_success"
      redirect_to admin_subjects_path
    else
      flash[:danger] = t "admin.subject.flash.flash_update_fail"
      render :edit
    end
  end

  def create
    if @subject.save
      SubjectNotifierUser.new.mail_to_user_when_create @subject
      flash[:success] = t "admin.subject.new_subject_success"
      redirect_to admin_subjects_path
    else
      flash[:danger] = t "admin.subject.new_subject_fail"
      render :new
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t "admin.subject.destroy_success"
    else
      flash[:danger] = t "admin.subject.destroy_fail"
    end
    redirect_to admin_subjects_path
  end

  private
  def subject_params
    params.require(:subject).permit :name
  end
end
