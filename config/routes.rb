Rails.application.routes.draw do
  
  
  # scope "/:locale", locale: /en|ar/ do
    
    
    devise_for :users, controllers: {
      sessions: 'users/sessions'
    }
    
    resources :dashboard, only: [:index]
    
    get 'terms', to: 'dashboard#terms'

    resources :users do
      # collection do
      #   delete 'delete_all'
      # end
    end
    
    resources :logs, only: [:index, :create, :show]
    get 'log/download', to: 'logs#download'
    get 'log/export', to: 'logs#export'
    
    resources :students do
      collection do
        get :upload
        get 'export_all'
        post :import
        post :lookup
        delete 'delete_all'
      end
    end

    resources :schools 
    # get 'qr_codes/index'
    get 'checkin', to: 'qr_codes#index'
    post 'checkin', to: 'qr_codes#create'
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    

    

    root to: 'dashboard#redirect_to_dashboard'
    
    match '*a', :to => 'errors#routing', via: :get
  # end
  
  # root to: 'dashboard#redirect_to_dashboard'

end
