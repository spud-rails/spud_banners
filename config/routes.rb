Rails.application.routes.draw do

  namespace :spud do
    namespace :admin do
      resources :banner_sets
      resources :banners
    end
  end

end