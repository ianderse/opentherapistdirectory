require 'rails_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

describe 'searching', type: :feature do
  include Capybara::DSL

  before do
  	5.times do
      Facility.create(name1: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, location_state: 'CO', location_zip: Faker::Address.zip, location_city: Faker::Address.city, location_street1: Faker::Address.street_address)
    end
    5.times do
      Facility.create(name1: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, location_state: 'OH', location_zip: Faker::Address.zip, location_city: Faker::Address.city, location_street1: Faker::Address.street_address)
    end
  end

  it 'can search by state abbreviation' do
  	expect(Facility.all.size).to eq(10)
  	visit '/'
  	fill_in "facilities_params", with: "CO"
  	click_on("Search")
  	# page.execute_script("$('form#search-form').submit()")
  	#not working, need to have a submit button
  	# save_and_open_page
  	# get :index
  	# @facilities = FacilitiesController.first_facilities
  	# raise @facilities.inspect
  	# expect(.size).to eq(5)
  end
end
