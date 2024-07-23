class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @parks = @user.parks
    @favorited_parks = @user.favorites.includes(:park).map { |favorite| favorite.park }
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'ユーザー情報を更新しました。'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to edit_user_path
    end
  end

end
