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

  before do
    5.times do
      create_therapist
    end
    user = User.create({provider: "twitter", uid: 'xyz456', name: 'Bob Jones', email: 'test@example.com', password: 'password', role: 'admin'})
    setup_user(user)
  end

  it 'can see a list of therapists' do
    sign_in
    visit '/admin/dashboard'
    expect(page).to have_content('List Therapists')
    click_on('List Therapists')
    expect(page).to have_content(Therapist.first.full_name)
  end

  it 'can toggle verification for therapist listing' do
    skip
    sign_in
    visit '/admin/dashboard'
    click_on('List Therapists')
    click_on(Therapist.first.full_name)
    expect(page).to have_content('More Information')
  end

  it 'can deactivate a therapist listing'
  it 'can click on a name for more information'

end

def create_therapist
  Therapist.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence, verified: false, sliding_scale: true, email: Faker::Internet.email, certifications: 'MA, LPC', cost: '$50-$100', picture: File.new(Rails.root + 'spec/images/Ian.jpg'))
end

def sign_in
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
