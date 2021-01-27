# frozen_string_literal: true

module App
  class Container
    extend Dry::Container::Mixin

    import App::Operations
  end
end
