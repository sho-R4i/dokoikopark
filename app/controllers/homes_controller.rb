class HomesController < ApplicationController
  def top
    redirect_to parks_path if current_user
  end

  def about
  end
end
