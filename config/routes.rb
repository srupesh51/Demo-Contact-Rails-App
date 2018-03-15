Rails.application.routes.draw do

  get 'contacts/create'

  get 'contacts/show'

  get '/welcome/index', to: "welcome#index"

  root "home#index"

  get '/user/login', to: "user#login"
  get '/user/signup', to: "user#signup"

  get '/contacts/create', to: "contacts#create"

  get '/contacts/show', to: "contacts#show"

  get '/user/logout', to: "user#logout"

  get '/contacts/edit', to: "contacts#edit"

  get '/contacts/delete', to: "contacts#delete"

  get '/contacts/reset', to: "contacts#reset"

  match 'auth/:provider/callback' => 'user#google_sign_in', :via => [:get]
  get 'auth/login_failure', to: redirect('/')

  scope :user, :controller => 'user' do
    post 'authenticate'
    post 'create'
  end

  scope :contacts, :controller => 'contacts' do
    post 'save_personal_contacts'
    post 'edit_personal_contacts'
    post 'filter'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
