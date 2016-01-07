class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.normal.page(params[:page]).per 10
  end

  def show
    @exams = current_user.exams.page(params[:page]).per 10
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.delete.delete_user_flash_success"
    else
      flash[:danger] = t "users.delete.delete_user_fail_fail"
    end
    redirect_to :back
  end
end
