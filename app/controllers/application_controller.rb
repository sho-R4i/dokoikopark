class ApplicationController < ActionController::Base

  private
 
  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end
end
