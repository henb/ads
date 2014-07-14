Ads::Application.routes.draw do

  resources :typeads, except: [:edit, :update]

  resources :myads do
    member do
      Myad.state_machine.events.map(&:name).each do |event|
        eval "get '#{event}'"
      end
    end

    collection do
      post 'update_all_state'
    end
  end

  root 'static_page#home'

  devise_for :users
  resources :users, except: [:new, :create]

end
