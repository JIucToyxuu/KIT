class FacultiesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :new]
  before_filter :admin_user,     only: [:create, :destroy, :new]

  def new
    if current_user.admin?
      @faculty_items = Faculty.paginate(page: params[:page])
      @faculty = Faculty.new
    else
      redirect_to root_path
    end
  end

  def create
    @faculty = Faculty.new(params[:faculty])
    if @faculty.save
      redirect_to new_faculty_path
    else
      render 'new'
    end
  end

  def destroy 
    Faculty.find_by_id(params[:id]).destroy
    flash[:success] = "Faculty destroyed."
    redirect_to new_faculty_path
  end


  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end