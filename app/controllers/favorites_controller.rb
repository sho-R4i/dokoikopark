class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  
  def create
    @park_favorite = Favorite.new(user_id: current_user.id, park_id: params[:park_id])
    @park_favorite.save
      redirect_to park_path(params[:park_id])
  end
  
  def destroy
    @park_favorite = Favorite.find_by(user_id: current_user.id, park_id: params[:park_id])
    @park_favorite.destroy
    redirect_to park_path(params[:park_id])
  end
  
  private
  
  def favorite_params
    params.require(:favorite).permit(:user_id, :park_id)
  end
  
end
