class ParksController < ApplicationController
  def new
    @park = Park.new
  end

  def create
    @park = Park.new(park_params)
    @park.user_id = current_user.id
    if @park.save
      flash[:notice] = '公園の情報を投稿しました。'
      redirect_to park_path
    else
      @parks = Park.all
      render :index
    end
  end

  def index
    @parks = Park.all
  end

  def show
    @park = Park.find(params[:id])
    @user = User.find(@park.user.id)
  end

  def edit
    is_matching_login_user
    @park = Park.find(params[:id])
  end

  def update
    is_matching_login_user
    @park = Park.find(params[:id])
    if @park.update(park_params)
      flash[:notice] = '公園の情報を更新しました。'
      redirect_to park_path
    else
      render :edit
    end
  end


  def destroy
    @park = Park.find(params[:id])
    if @park.destroy
      flash[:notice] = '公園の情報を削除しました。'
      redirect_to parks_path
    else
    end
  end

  private

  def park_params
    params.require(:park).permit(:park_name)
  end

  def is_matching_login_user
    park = Park.find(params[:id])
    unless park.user.id == current_user.id
      redirect_to parks_path
    end
  end

end