Ads::Application.routes.draw do

  resources :typeads, except: [:edit,:update]

  resources :myads do
    member do
      get "event"
    end

    collection do
      get "published"
      post "update_all_state"

    end
  end

  root "static_page#home"
  get "static_page/about"

  devise_for :users 
  resources :users, except: [:new,:create]

end
