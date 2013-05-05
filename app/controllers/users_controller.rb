class UsersController < ApplicationController
  before_filter :signed_in_user, 
                only: [:index, :edit, :update, :destroy, :following, :followers, :addjob, :toadmin]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:destroy, :toadmin]

  def new
  	@user = User.new
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def create
    @user = User.new(params[:user])
    @branch = Branch.find_by_namebranch(@user.branch)
    @user.chair = @branch.chair.namechair
    @user.faculty = @branch.chair.faculty.namefaculty
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the KIT!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    session[:domain_id] = params[:id]
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit    
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def update
    @branch = Branch.find_by_namebranch(params[:user][:branch])
    params[:user][:chair] = @branch.chair.namechair
    params[:user][:faculty] = @branch.chair.faculty.namefaculty
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def jobss     
    @user = User.find(params[:id])   
    @jobs = @user.jobs.paginate(page: params[:page])
    if signed_in?
      @job =current_user.jobs.build
      @job.active = true
      @jobs_items = current_user.jobs.paginate(page: params[:page])
    end
  end



   

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def toadmin
      @user = User.find_by_id(params[:user][:id])
      @user.toggle!(:admin)
      if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to users_path
    else
      render 'index'
    end
    end

   
end