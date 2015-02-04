require 'rails_helper'

RSpec.describe Therapist, :type => :model do
  it 'can get full name' do
    therapist = Therapist.create(first_name: 'test', last_name: 'user')
    expect(therapist.full_name).to eq('test user')
  end

  it 'has an address' do
    therapist = Therapist.create(first_name: 'test', last_name: 'user', id: 1)
    location = Location.create(street_1: '123 test street', street_2: 'Apt. 301', city: 'Denver', state: 'CO', zipcode: '80202', therapist_id: 1)

    expect(therapist.location.street_1).to eq('123 test street')
  end
end
