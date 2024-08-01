class ParksController < ApplicationController
  def new
    @park = Park.new
  end

  def create
    @park = Park.new(park_params)
    @park.user_id = current_user.id
    tag_list = params[:park][:name].split(',')
    if @park.save
      @park.save_tag(tag_list)
      flash[:notice] = '公園の情報を投稿しました。'
      redirect_to parks_path
    else
      flash.now[:alert] = '投稿に失敗ました。'
      @parks = Park.all
      render :new
    end
  end

  def index
    @parks = Park.all
    
    if params[:address_keyword].present?
      @parks = @parks.where("address LIKE ?", "%#{params[:address_keyword]}%")
    elsif params[:park_name_keyword].present?
      @parks = @parks.where("park_name LIKE ?", "%#{params[:park_name_keyword]}%")
    end
    
    @tag_list = Tag.all
    @parks = @parks.includes(:post_tags).where('post_tags.tag_id': params[:tag_id]) if params[:tag_id].present?
    
    respond_to do |format|
      format.html do
        @parks
      end
      format.json do
        @parks
      end
    end
  end
  
  def search_tag
    @tag_list=Tag.all
    @tag=Tag.find(params[:tag_id])
    @parks=@tag.parks.page(params[:page]).per(10)
  end

  def show
    respond_to do |format|
      format.html do
        @park = Park.find(params[:id])
        @user = User.find(@park.user.id)
      end
      format.json do
        @park = Park.find(params[:id])
      end
    end
    @comments = @park.comments
    @comment = Comment.new
    @park_favorites_count = Favorite.where(park_id: @park.id).count
    @post_tags = @park.tags
  end

  def edit
    is_matching_login_user
    @park = Park.find(params[:id])
    @tag_list = @park.tags.pluck(:name).join(',')
  end

  def update
    is_matching_login_user
    @park = Park.find(params[:id])
    tag_list = params[:park][:name].split(',')
    if @park.update(park_params)
      @park.save_tag(tag_list)
      flash[:notice] = '公園の情報を更新しました。'
      redirect_to park_path(@park)
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
    params.require(:park).permit(:park_name, :park_introduction, :address, :image, :star)
  end
  
  def is_matching_login_user
    park = Park.find(params[:id])
    unless park.user.id == current_user.id
      redirect_to parks_path
    end
  end

end