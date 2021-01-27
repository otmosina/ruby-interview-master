# frozen_string_literal: true

module App
  Operations = Dry::Container::Namespace.new('operations') do
    namespace 'params' do
      register('deserialize') { ::Params::DeserializeOperation.new }
    end
  end
end
