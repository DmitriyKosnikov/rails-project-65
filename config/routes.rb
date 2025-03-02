Rails.application.routes.draw do
  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    resources 'auth', only: :destroy
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
