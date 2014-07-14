Ads::Application.routes.draw do

  resources :typeads, except: [:edit, :update]

  resources :myads do
    member do
      get 'draft'
      get 'fresh'
      get 'reject'
      get 'approve'
      get 'publish'
      get 'archive'
      get 'ban'
    end

    collection do
      post 'update_all_state'
    end
  end

  root 'static_page#home'

  devise_for :users
  resources :users, except: [:new, :create]

end
