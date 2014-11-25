require 'rails_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.default_wait_time = 5

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :window_size => [1920, 1080], :phantomjs_logger => nil, :js_errors => false)
end

describe 'authenticated user', type: :feature do
  include Capybara::DSL
  OmniAuth.config.test_mode = true

  before do
  	5.times do
      Facility.create(name1: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, location_state: 'CO', location_zip: Faker::Address.zip, location_city: Faker::Address.city, location_street1: Faker::Address.street_address)
    end
	  user = User.create({provider: "twitter", uid: 'xyz456', name: 'Bob Jones', email: 'test@example.com', password: 'password'})
  	setup_user(user)
  end

  it 'can sign out' do
  	visit '/'
  	click_link('Sign in with Twitter')
  	visit '/'
  	click_link('Sign Out')
  	expect(page).to have_content('Sign Up/Login')
  end

  # it 'can save a facility to a list', js: true do

		# visit '/'
	  # sign_in = find(:css, '.twitter-auth')
	  # sign_in.trigger('click')
  # 	visit '/'
  # 	click_link('Mental Health Resources')
  # 	save_and_open_screenshot
  # 	click_link('Save Facility')
  # 	visit '/user'
  # 	expect(page).to have_content('My Saved Facilities')
  # end
end

def setup_user(user)
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    'provider' => 'twitter',
    'uid' => user.uid,
    'info' => { "name" => user.name }
  })
end
