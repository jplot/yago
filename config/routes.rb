Rails.application.routes.draw do

  resources :professional_liability, only: [] do
    collection do
      post :quotas
    end
  end
end
