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

describe 'unauthenticated user', type: :feature do
  include Capybara::DSL
  OmniAuth.config.test_mode = true

 #  before do
	#   request.env["devise.mapping"] = Devise.mappings[:user] # If using Devise
	#   request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
	# end

  before do
  	5.times do
      Facility.create(name1: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, location_state: 'CO', location_zip: Faker::Address.zip, location_city: Faker::Address.city, location_street1: Faker::Address.street_address)
    end
  end

  it "can browse all mental health resources" do
    visit '/'
    click_link 'Mental Health Resources'
    expect(current_path).to eq(facilities_path)
    expect(page).to have_content 'Mental Health Resource Finder'
  end

  it "can create a new user with Twitter account" do
    user = User.create({provider: "twitter", uid: 'xyz456', name: 'Bob Jones', email: 'test@example.com', password: 'password'})
    user.save!
    expect(User.count).to eq(1)
  end

  it 'can login with a twitter account' do
  	user = User.create({provider: "twitter", uid: 'xyz456', name: 'Bob Jones', email: 'test@example.com', password: 'password'})
  	log_in(user)
	  visit '/'
	  click_link('Sign in with Twitter')
	  expect(page).to have_content('Signed in as Bob Jones')
  end

  # it "can sort facilities by name", js: true do
  # 	sorted_facilities = Facility.all.sort_by {|facility| facility.name1}
  # 	visit '/'
  # 	click_link 'Mental Health Resources'
  # 	save_and_open_screenshot
  # 	within(:css, ".list") do
  # 		# first_item = first('li')
  # 		expect(page).to have_content(sorted_facilities.first.name1)
  # 	end
  # end

  # it "can sort facilities by city", js: true do
  # end
end


def log_in(user)
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    'provider' => 'twitter',
    'uid' => user.uid,
    'info' => { "name" => user.name }
  })
end
