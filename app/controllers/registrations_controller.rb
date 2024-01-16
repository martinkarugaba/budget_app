class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: %i[new create]

  protected

  def after_sign_up_path_for(_resource)
    new_user_session_path # Or whatever path you want
  end
end
