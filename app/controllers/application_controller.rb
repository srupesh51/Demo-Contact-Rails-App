class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  helper_method :current_user, :current_contact
  def current_user
    @current_user = nil
    if cookies[:user_id]
      @current_user = Users.find(cookies[:user_id])
    end
  end
  def current_contact
    @current_contact = nil
    if cookies[:user_id]
      @current_contact = Contacts.find_by(users_id: cookies[:user_id])
    end
  end
end
