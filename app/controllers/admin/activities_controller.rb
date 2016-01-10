class Admin::ActivitiesController < ApplicationController

  def index
    @activitys = Activity.page(params[:page]).per 10
  end
end
