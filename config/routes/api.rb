# frozen_string_literal: true

api_v1_routes = lambda do
  constraints(id: /\d+/) do
    draw :'api/v1/users'
  end
end

namespace :api do
  namespace :v1, &api_v1_routes
end
scope module: :api do
  namespace :v1, &api_v1_routes
end
