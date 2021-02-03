# frozen_string_literal: true
module Types
    include Dry::Types()
  
    StrippedString = Types::String.constructor(&:strip)
    AEmailer = Types.Constructor(ApplicationMailer)#
    Emailer = Types.Constructor(UserMailer)
end
