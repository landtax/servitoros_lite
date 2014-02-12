Servitoros::Application.routes.draw do
  root :to => 'home#index'

  #devise_for :admin_users, ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)

  get "home/index"
  get "more_info", :to => "home#more_info"
  get "faq", :to => "home#faq"
  get "credits", :to => "home#credits"

  devise_for :users
  #ActiveAdmin.routes(self)

  resources :executions do
    member { post 'notify' }
    collection do
      post 'notify'
      get 'executions_list'
    end
  end

  resources :uploaded_files, :path => "files", :controller => :files
  resources :files

end
