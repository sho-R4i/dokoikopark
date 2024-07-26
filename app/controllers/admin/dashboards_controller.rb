class Admin::DashboardsController < ApplicationController

    
    before_action :authenticate_admin!
    
    def index
        @users = User.all
        @users = @users.where('name LIKE(?)', "%#{params[:keyword]}%") if params[:keyword].present?
    end
end
