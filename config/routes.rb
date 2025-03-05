Rails.application.routes.draw do
  scope module: 'web' do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'logout', to: 'auth#destroy', as: :logout

    resources :bulletins, except: :index

    root 'bulletins#index'

    namespace :admin do
      get '/', to: 'bulletins#moderation'

      resources :bulletins
      resources :categories
    end
  end
end
