class UsersController < ApplicationController
  before_filter :signed_in_user, 
                only: [:index, :edit, :update, :destroy, :following, :followers, :addjob, :toadmin, :index]
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
    @str = ""
    i = 0
    name = params[:name]
    family_name = params[:family_name]
    patronymic = params[:patronymic]
    faculty = params[:faculty]
    chair = params[:chair]
    branch = params[:branch]
    year_off = params[:year_off]

    if !(params[:name].nil? | params[:name].blank?)      
      if i == 0
        @str += "name = \'" + name +"\'"
        i+=1
      else
        @str += " AND name = \'" + name +"\'"
        i++1
      end     
    end

    if !(params[:family_name].nil? | params[:family_name].blank?)
      if i == 0
        @str += "family_name = \'" + family_name +"\'"
        i+=1
      else
        @str += " AND family_name = \'" + family_name +"\'"
        i++1
      end     
    end

    if !(params[:patronymic].nil? | params[:patronymic].blank?)
      if i == 0
        @str += "patronymic = \'" + patronymic +"\'"
        i+=1
      else
        @str += " AND patronymic = \'" + patronymic +"\'"
        i++1
      end     
    end

    if !(params[:faculty].nil? | params[:faculty].blank?)
      if i == 0
        @str += "faculty = \'" + faculty +"\'"
        i+=1
      else
        @str += " AND faculty = \'" + faculty +"\'"
        i++1
      end     
    end

    if !(params[:chair].nil? | params[:chair].blank?)
      if i == 0
        @str += "chair = \'" + chair +"\'"
        i+=1
      else
        @str += " AND chair = \'" + chair +"\'"
        i++1
      end     
    end

    if !(params[:branch].nil? | params[:branch].blank?)
      if i == 0
        @str += "branch = \'" + branch +"\'"
        i+=1
      else
        @str += " AND branch = \'" + branch +"\'"
        i++1
      end     
    end

    if !(params[:year_off].nil? | params[:year_off].blank?)
      if i == 0
        @str += "year_off = \'" + year_off +"\'"
        i+=1
      else
        @str += " AND year_off = \'" + year_off +"\'"
        i++1
      end     
    end


    if @str == ""
      @users = User.all
    else
      @query = "SELECT * FROM users  WHERE "  + @str
      @users = User.find_by_sql(@query)
    end
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

  def delete_job
    Job.find(params[:id]).destroy
    flash[:success] = "Job destroyed."
    redirect_to jobss_user_path(current_user)
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