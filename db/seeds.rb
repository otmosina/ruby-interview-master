# frozen_string_literal: true

unless Rails.env.test?
  Dir[File.dirname(__FILE__) + '/seeds/*.rb'].sort.each do |file|
    puts "Seeds #{file} ..."
    require file
  end
end
