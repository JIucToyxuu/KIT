class JobsController < ApplicationController
  before_filter :signed_in_user

  def index
    @job = current_user.jobs.build if signed_in?
  end

  def new
    
  end

  def destroy
  end

  def create
    @job = current_user.jobs.build(params[:job])    
      @job.active = true
    if @job.save
      flash[:success] = "Job create!"
      redirect_to jobss_user_path(current_user)
    else
      redirect_to root_url
    end
  end
end