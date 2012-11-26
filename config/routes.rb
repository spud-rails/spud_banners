Rails.application.routes.draw do

  namespace :spud do
    namespace :admin do
      resources :banner_sets do
        resources :banners, :only => [:new, :create]
      end
      resources :banners, :only => [:show, :edit, :update, :destroy] do
        put :sort, :on => :collection
      end
    end
  end

end