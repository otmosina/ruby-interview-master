# frozen_string_literal: true

require 'dry/monads/try'

class ApplicationOperation
  delegate :configuration, to: 'Rails'
end
