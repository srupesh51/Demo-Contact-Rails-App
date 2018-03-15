require 'open-uri'
class UserController < ApplicationController
  include ContactsHelper
  helper_method :current_user
  def authenticate
    currentUserId = Users.authenticateUser(params["username"],params["password"])
    if currentUserId != nil
      cookies[:user_id] = currentUserId
      redirect_to root_path
    else
      flash[:error] = "Login Failed!"
      redirect_to '/user/login'
    end
  end

  def create
    currentUserId = Users.createUser(params)
    if currentUserId != nil
      cookies[:user_id] = currentUserId
      redirect_to root_path
    else
      flash[:error] = "User Already Exists!"
      redirect_to '/user/signup'
    end
  end

  def google_sign_in
    auth = request.env["omniauth.auth"]
    auth['user_type'] = 'google'
    user = Users.from_omniauth(auth)
    cookies[:user_id] = user.users_id
    currentUser = current_user
    token = Users.get_token(currentUser)
    if current_contact == nil
      contacts_json = JSON.parse(open("https://www.google.com/m8/feeds/contacts/default/full?access_token="+token+"&alt=json").read)
      contacts_json = parse_contact(contacts_json, currentUser)
      Contacts.save_contacts(contacts_json, auth['user_type'])
    end
    redirect_to root_path
  end

  def signup
  end

  def login
  end

  def logout
    cookies.delete :user_id
    redirect_to root_path
  end
end
