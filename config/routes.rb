Rui::Application.routes.draw do  
  resources :responses


  resources :issues do
    resources :responses
  end


  authenticated :user do
    root :to => 'homes#index', as: :authenticated_root
  end
  
  resources :homes
  
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  
  scope "/admin" do
    resources :users
  end  
  
  devise_scope :user do
    root :to => "devise/sessions#new"
  end  
end
