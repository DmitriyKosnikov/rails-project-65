# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: 'web' do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'logout', to: 'auth#destroy', as: :logout

    get 'profile', to: 'profile#index'

    resources :bulletins do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    root 'bulletins#index'

    namespace :admin do
      get '/', to: 'bulletins#moderation'

      resources :bulletins, except: %i[new create edit update destroy show] do
        member do
          patch :reject
          patch :publish
          patch :archive
        end
      end

      resources :categories, except: %i[show]
    end
  end
end
