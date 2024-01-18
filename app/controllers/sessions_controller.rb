# app/controllers/sessions_controller.rb
class SessionsController < Devise::SessionsController
  # skip_before_action :require_no_authentication, only: %i[new create]

  private

  def after_sign_in_path_for(_resource)
    categories_path
  end
end
