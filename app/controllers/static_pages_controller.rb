class StaticPagesController < ApplicationController
  def home
    @activitys = Activity.all.page(params[:page]).per 10
  end

  def about
  end
end
