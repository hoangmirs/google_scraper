require 'simplecov'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::HTMLFormatter])

if ENV['CIRCLE_ARTIFACTS']
  dir = File.join('..', '..', '..', ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
end

SimpleCov.start 'rails' do
  add_filter '/vendor/'
  add_filter '/config/'
  add_filter '/spec/'
  add_filter '/db/'
  add_group "Services", "app/services"
  add_group "Workers", "app/workers"
  add_group "Queries", "app/queries"
end
