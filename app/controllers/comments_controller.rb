class CommentsController < ApplicationController
	before_filter :signed_in_user, only: :destroy
	
	def destroy
		Comment.find(params[:id]).destroy
		redirect_to request.referer
	end

end