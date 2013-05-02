class StaticPagesController < ApplicationController
	
  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
    @user = User.find(session[:domain_id])
    @jobs_items = @user.jobs.paginate(page: params[:page])
  end

  def contact
  end

  
end
