# frozen_string_literal: true

RSpec.shared_context 'with timecop' do
  around do |example|
    Timecop.freeze(Time.current.change(nsec: 0)) { example.run }
  end
end
