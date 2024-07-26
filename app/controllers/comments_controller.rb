class CommentsController < ApplicationController
    def create
      @comment = current_user.comments.new(comment_params)
      @park = @comment.park
      if @comment.save
        flash[:notice] = "success"
        redirect_to park_path(@park)
      else
        @comments = @park.comments
        @park_favorites_count = Favorite.where(park_id: @park.id).count
        flash.now[:alert] = "failed"
        render "parks/show"
      end
    end
    
    private
    def comment_params
      params.require(:comment).permit(:comment, :park_id)
    end
end
