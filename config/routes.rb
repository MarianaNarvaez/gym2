Rails.application.routes.draw do
  get 'images/index'

  resources :images
  
  devise_for :users
  get 'welcome/index'
  root 'welcome#index'

  scope '/marigym' do
  	get 'welcome/index'
    resources :images
    root 'welcome#index'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
