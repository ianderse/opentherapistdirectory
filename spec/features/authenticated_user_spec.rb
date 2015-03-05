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
    click_link('Resources')
    click_link('Articles')
    first_accordion = first('.accordion')
    within(first_accordion) do
      first(:link, "Share this").click
    end
    expect(page).to have_content("Friend's Email")
  end

  it 'can save a facility to a list', js: true do
		sign_in_js
    click_link('Resources')
  	click_link('Mental Health Resources')
    select('CO', :from => 'filter-state')
    first('.add-facility').click
  	visit '/user'
  	expect(page).to have_content('My Saved Facilities')
  end

  it 'can delete a facility from users saved list', js: true do
    sign_in_js
    click_link('Resources')
    click_link('Mental Health Resources')
    select('CO', :from => 'filter-state')
    first('.add-facility').click
    visit '/user'
    page.execute_script("$('#remove_facility_#{Facility.first.id}').show()")
  end

  it 'can view more information on a facility', js: true do
    sign_in_js
    click_link('Resources')
    click_link('Mental Health Resources')
    select('CO', :from => 'filter-state')
    first('.more-information').click
    expect(page).to have_content(Facility.first.name1)
  end

  describe 'therapist view' do
    it 'can view a listing of all therapists', js: true do
      create_therapist
      sign_in_js
      click_link('Find a Therapist', :match => :first)
      expect(page).to have_content(Therapist.first.full_name)
    end

    it 'can view more information on a therapist', js: true do
      create_therapist
      sign_in_js
      click_link('Find a Therapist', :match => :first)
      click_link('More Information')
    end

    it 'can sign up to list as a therapist' do
      skip
      sign_in
      click_link('List Your Practice')
      expect(page).to have_content("List Your Practice")
      fill_in 'therapist_first_name', :with => 'Test'
      fill_in 'therapist_last_name', :with => 'Therapist'
      fill_in 'therapist_email',     :with => 'test@example.com'
      fill_in 'therapist_certifications', :with => 'MA, LPC'
      fill_in 'therapist_cost', :with => '$50 - $100'
      fill_in 'therapist_location_attributes_street_1', :with => '123 Test Street'
      fill_in 'therapist_location_attributes_street_2', :with => 'Unit 222'
      fill_in 'therapist_location_attributes_city', :with => 'Denver'
      select "CO", :from => "therapist_location_attributes_state"
      fill_in 'therapist_location_attributes_zipcode', :with => '80202'
      fill_in 'therapist_location_attributes_phone', :with => '123-123-1234'
      attach_file "therapist_picture", "spec/images/Ian.jpg"
      click_on('List Practice')
      expect(page).to have_content('Thank you for Submitting your Practice')
      expect(Therapist.all.size).to eq(1)
      expect(Therapist.last.location.city).to eq('Denver')
    end

    it 'can only create one therapist listing per user' do
      sign_in
      user = User.first
      Therapist.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence, verified: true, active: true, sliding_scale: true, email: Faker::Internet.email, certifications: 'MA, LPC', cost: '$50-$100', picture: File.new(Rails.root + 'spec/images/Ian.jpg'), user_id: user.id)
      visit '/'
      expect(page).to have_content('Edit Your Practice')
    end

    it 'can edit its listing' do
      sign_in
      user = User.first
      therapist = Therapist.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence, verified: true, active: true, sliding_scale: true, email: Faker::Internet.email, certifications: 'MA, LPC', cost: '$50-$100', picture: File.new(Rails.root + 'spec/images/Ian.jpg'), user_id: user.id)
      visit "/therapists/#{therapist.id}/edit"
      expect(current_path).to eq(edit_therapist_path(therapist.id))
      expect(page).to have_button('Update Practice')
    end

    it 'cannot edit another listing' do
      create_therapist
      sign_in
      user = User.first
      therapist_2 = Therapist.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence, verified: true, active: true, sliding_scale: true, email: Faker::Internet.email, certifications: 'MA, LPC', cost: '$50-$100', picture: File.new(Rails.root + 'spec/images/Ian.jpg'), user_id: user.id)
      visit "/therapists/#{Therapist.first.id}/edit"
      expect(current_path).to eq(root_path)
    end

    it 'can de-activate its own listing' do
      sign_in
      user = User.first
      therapist = Therapist.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence, verified: true, active: true, sliding_scale: true, email: Faker::Internet.email, certifications: 'MA, LPC', cost: '$50-$100', picture: File.new(Rails.root + 'spec/images/Ian.jpg'), user_id: user.id)
      visit "/therapists/#{therapist.id}/edit"
      click_button('De-Activate Listing')
      visit '/'
      click_link('Find a Therapist', :match => :first)
      expect(page).to_not have_content(therapist.full_name)
    end

    it 'can share a therapist'

  end
end

def create_therapist
  therapist = Therapist.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence, verified: true, active: true, sliding_scale: true, email: Faker::Internet.email, certifications: 'MA, LPC', cost: '$50-$100', picture: File.new(Rails.root + 'spec/images/Ian.jpg'))
  Location.create(city: 'Denver', state: 'CO', zipcode: '80202', street_1: '123 Test Street', street_2: 'Apt. 301', phone: '222-222-2222', therapist_id: therapist.id)
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
