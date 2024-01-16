# app/controllers/sessions_controller.rb
class SessionsController < Devise::SessionsController
  skip_before_action :require_no_authentication, only: %i[new create]
end
