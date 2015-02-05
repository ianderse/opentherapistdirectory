require 'rails_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.default_wait_time = 5

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :inspector => true, :window_size => [1920, 1080], :js_errors => false)
end

describe 'admin user', type: :feature do
  include Capybara::DSL
  OmniAuth.config.test_mode = true

  it 'can see a list of therapists'
  it 'can toggle verification for therapist listing'
end
