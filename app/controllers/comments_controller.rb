class CommentsController < ApplicationController
    before_action :authenticate_user!
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
    
    def destroy
      @comment = current_user.comments.find_by_id(params[:id])
      @comment.destroy if @comment
      redirect_to user_path(current_user), notice: 'コメントを削除しました。'
    end
    
    private
    def comment_params
      params.require(:comment).permit(:comment, :park_id)
    end
end
