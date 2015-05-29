class CommentsController < ApplicationController
  before_filter :signed_in_user, only: [:destroy, :create]

  def create
    @comment = current_user.comments.build(params[:comment])
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to root_url
    else
      flash[:success] = "Micropost NOOOOO created!"
      redirect_to root_url
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end
end
