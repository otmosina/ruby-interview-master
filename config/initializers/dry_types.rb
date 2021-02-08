# frozen_string_literal: true
module Types
    include Dry::Types()
    Emailer = Types.Constructor(UserMailer)
end
