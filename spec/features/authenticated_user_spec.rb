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
  	sign_in
  	visit '/'
  	click_link('Sign Out')
  	expect(page).to have_content('Sign Up/Login')
  end

  it 'can share an article' do
    sign_in
    click_link('Articles')
    first_accordion = first('.accordion')
    within(first_accordion) do
      first(:link, "Share this").click
    end
    expect(page).to have_content('Share article with')
  end

  it 'can save a facility to a list', js: true do
		sign_in_js
  	click_link('Mental Health Resources')
    select('CO', :from => 'filter-state')
    first('.add-facility').click
  	visit '/user'
  	expect(page).to have_content('My Saved Facilities')
  end

  it 'can delete a facility from users saved list', js: true do
    sign_in_js
    click_link('Mental Health Resources')
    select('CO', :from => 'filter-state')
    first('.add-facility').click
    visit '/user'
    page.execute_script("$('#remove_facility_#{Facility.first.id}').show()")
  end

  it 'can view more information on a facility', js: true do
    sign_in_js
    visit '/'
    click_link('Mental Health Resources')
    select('CO', :from => 'filter-state')
    first('.more-information').click
    expect(page).to have_content(Facility.first.name1)
  end

  describe 'therapist view' do
    it 'can view a listing of all therapists' do
      create_therapist
      sign_in
      click_link('Find a Therapist')
      expect(page).to have_content(Therapist.first.full_name)
    end

    it 'can view more information on a therapist' do
      create_therapist
      sign_in
      click_link('Find a Therapist')
      click_link(Therapist.first.full_name)
    end

    it 'can sign up to list as a therapist' do
      sign_in
      click_link('List Your Practice')
      expect(page).to have_content("List Your Practice")
      fill_in 'therapist_first_name', :with => 'Test'
      fill_in 'therapist_last_name', :with => 'Therapist'
      fill_in 'therapist_email',     :with => 'test@example.com'
      fill_in 'therapist_certifications', :with => 'MA, LPC'
      fill_in 'therapist_cost', :with => '$50 - $100'
      click_on('List Practice')
      expect(page).to have_content('Thank you for Submitting your Practice')
    end

    it 'must have an admin approve a therapist listing before listing shows up'
    it 'can edit its listing'
    it 'cannot edit another listing'
    it 'can share a therapist'

  end
end

def create_therapist
  Therapist.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence, verified: true, sliding_scale: true, email: Faker::Internet.email, certifications: 'MA, LPC', cost: '$50-$100')
end

def sign_in
  visit '/'
  click_link('Sign in with Twitter')
end

def sign_in_js
  visit '/'
  click_link('Sign Up/Login')
  click_link('Sign in with Twitter')
end

def setup_user(user)
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    'provider' => 'twitter',
    'uid' => user.uid,
    'info' => { "name" => user.name }
  })
end
