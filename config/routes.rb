Rails.application.routes.draw do
  root "pages#home"
  devise_for :users

  resources :organizations do
    resources :memberships
    resources :boards do
      resources :lists do
        resources :cards
      end
    end
  end

  resources :cards, only: [] do
    member do
      patch :update_position
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
