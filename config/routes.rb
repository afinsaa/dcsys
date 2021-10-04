Rails.application.routes.draw do
  
  
  # scope "/:locale", locale: /en|ar/ do
    resources :logs
    
    devise_for :users, controllers: {
      sessions: 'users/sessions'
    }
    

    resources :dashboard do
      
      
    end
    get 'dashboard/terms'

    resources :users do
      # collection do
      #   delete 'delete_all'
      # end
    end
    

    
    resources :students do
      collection do
        get :upload
        post :import
        post :lookup
        delete 'delete_all'
      end
    end

    resources :schools
    # get 'qr_codes/index'
    get 'checkin', to: 'qr_codes#index'
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    

    

    root to: 'dashboard#redirect_to_dashboard'
    
  # end
  
  # root to: 'dashboard#redirect_to_dashboard'

end
