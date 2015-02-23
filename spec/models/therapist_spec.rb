require 'rails_helper'

RSpec.describe Therapist, :type => :model do
  it 'can get full name' do
    therapist = Therapist.create(first_name: 'test', last_name: 'user')
    expect(therapist.full_name).to eq('test user')
  end

  it 'has an address' do
    therapist = Therapist.create(first_name: 'test', last_name: 'user', id: 1, certifications: 'MA', email: 'test@example.com', cost: '$50-$100', sliding_scale: true, picture: File.new(Rails.root + 'spec/images/Ian.jpg'))
    location = Location.create(street_1: '123 test street', street_2: 'Apt. 301', city: 'Denver', state: 'CO', zipcode: '80202', phone: '123-123-1234', therapist_id: 1)

    expect(therapist.location.street_1).to eq('123 test street')
  end

  it 'must have a first name' do
    therapist = Therapist.new(first_name: '', last_name: 'user', id: 1, certifications: 'MA', email: 'test@example.com', cost: '$50-$100', sliding_scale: true, picture: File.new(Rails.root + 'spec/images/Ian.jpg'))

    expect(therapist.save).to be(false)
  end

  it 'must have a last name' do
    therapist = Therapist.new(first_name: 'test', last_name: '', id: 1, certifications: 'MA', email: 'test@example.com', cost: '$50-$100', sliding_scale: true, picture: File.new(Rails.root + 'spec/images/Ian.jpg'))
    expect(therapist.save).to be(false)
  end

  it 'defaults to verified false' do
    therapist = Therapist.create(first_name: 'test', last_name: 'user', id: 1, certifications: 'MA', email: 'test@example.com', cost: '$50-$100', sliding_scale: true, picture: File.new(Rails.root + 'spec/images/Ian.jpg'))
    expect(therapist.verified).to be(false)
  end

  it 'must have an email' do
    therapist = Therapist.new(first_name: 'test', last_name: 'user', id: 1, certifications: 'MA', email: '', cost: '$50-$100', sliding_scale: true, picture: File.new(Rails.root + 'spec/images/Ian.jpg'))
    expect(therapist.save).to be(false)
  end

  it 'must have certifications' do
    therapist = Therapist.new(first_name: 'test', last_name: 'user', id: 1, certifications: '', email: 'test@example.com', cost: '$50-$100', sliding_scale: true, picture: File.new(Rails.root + 'spec/images/Ian.jpg'))
    expect(therapist.save).to be(false)
  end

  it 'must have an average cost' do
    therapist = Therapist.new(first_name: 'test', last_name: 'user', id: 1, certifications: 'MA', email: 'test@example.com', cost: '', sliding_scale: true, picture: File.new(Rails.root + 'spec/images/Ian.jpg'))
    expect(therapist.save).to be(false)
  end

  it { should have_attached_file(:picture) }
  it { should validate_attachment_presence(:picture) }
  it { should validate_attachment_content_type(:picture).
                allowing('image/png', 'image/gif', 'image/jpg', 'image/jpeg').
                rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_size(:picture).
                less_than(2.megabytes) }
end
