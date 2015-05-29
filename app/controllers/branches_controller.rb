class BranchesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :new]
  before_filter :admin_user,     only: [:create, :destroy, :new]

  def index
  end

  def new
    if current_user.admin?
      @branch_items = Branch.paginate(page: params[:page])
      @branch = Branch.new
    else
      redirect_to root_path
    end
  end

  def create
    @branch_items = Branch.paginate(page: params[:page])
    @branch = Branch.new(params[:branch])
    if @branch.save
      redirect_to new_branch_path
    else
      render 'new'
    end
  end

  def destroy
    Branch.find_by_id(params[:id]).destroy
    flash[:success] = "Branch destroyed."
    redirect_to new_branch_path
  end

  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end