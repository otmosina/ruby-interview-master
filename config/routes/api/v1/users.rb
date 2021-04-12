# frozen_string_literal: true

resources :users, only: :create do
  post :resend_confirmation_link, on: :collection
  post :confirm_email, on: :collection
end
resource :user, only: %i[show], controller: :user
