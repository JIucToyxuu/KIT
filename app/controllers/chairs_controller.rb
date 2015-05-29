class ChairsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :new]
  before_filter :admin_user,    only: [:create, :destroy, :new]


  def new
    if current_user.admin?
      @chair_items = Chair.paginate(page: params[:page])
      @chair = Chair.new
    else
      redirect_to root_path
    end
  end

  def create
    @chair_items = Chair.paginate(page: params[:page])
    @chair = Chair.new(params[:chair])
    if @chair.save
      redirect_to new_chair_path
    else
      render 'new'
    end
  end

  def destroy   
    Chair.find_by_id(params[:id]).destroy
    flash[:success] = "Chair destroyed."
    redirect_to new_chair_path
  end


  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end