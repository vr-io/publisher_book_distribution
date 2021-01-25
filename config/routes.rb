Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  resources :publishers, only: [] do
    resources :shops, only: [:index], defaults: {format: :json}
  end

  resources :shops, only: [] do
    resources :books, only: [] do
      resources :sells, only: :create
    end
  end
end
