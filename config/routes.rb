# frozen_string_literal: true

Rails.application.routes.draw do
  resource :status, only: %i[show]

  draw :api
  draw :sidekiq
end
