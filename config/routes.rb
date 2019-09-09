Rails.application.routes.draw do
  devise_for :clients, path: 'clients', controllers: {
      sessions: 'clients/sessions'
  }
  devise_for :staffs, path: 'staffs', controllers: {
      sessions: 'staffs/sessions'
  }

  root "application#index"

  namespace :clients do
    resources :home, only: [:index]
  end
  namespace :staffs do
    resources :home, only: [:index]
  end
end
