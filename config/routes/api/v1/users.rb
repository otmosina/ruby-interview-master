# frozen_string_literal: true

resources :users, only: :create
resource :user, only: %i[show], controller: :user
