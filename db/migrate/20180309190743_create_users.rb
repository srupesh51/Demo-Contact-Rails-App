class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, :primary_key => :users_id do |t|
      t.string :user_type
      t.string :username
      t.string :password
      t.string :user
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.string :refresh_token
      t.datetime :oauth_expires_at
      t.timestamps
    end
  end
end
