# frozen_string_literal: true

resources :users, only: :create do
    get :confirmation_email, on: :collection
end
resource :user, only: %i[show], controller: :user
