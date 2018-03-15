require 'bcrypt'
class Users < ApplicationRecord
  include BCrypt
  self.primary_key = :users_id
  has_many :contacts
  def self.createUser params
    userList = self.where(user_type: params[:user_type],username: params[:username])
    if !userList.empty?
      nil
    else
      @user = self.create({username: params["username"], user_type: params[:user_type],
        password: Password.create(params["password"])})
      @user.save!
      @user[:users_id]
    end
  end

  def self.authenticateUser email, password
    @user = self.where(username: email)
    return Password.new(@user[0][:password]) == password ? @user[0][:users_id]: nil
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.user_type = auth.user_type
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.refresh_token = auth.credentials.refresh_token
      user.save!
    end
  end

  def self.get_token(user)
    token = user.oauth_token
  end

end
