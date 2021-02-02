# frozen_string_literal: true

resources :users, only: :create do
    get :send_confirmation_link, on: :collection
    get :resend_confirmation_link, on: :collection
    get :confirmation_email, on: :collection
end
resource :user, only: %i[show], controller: :user
