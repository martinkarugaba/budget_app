class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(_resource)
    groups_path # This will redirect the user to the groups index view
  end
end
