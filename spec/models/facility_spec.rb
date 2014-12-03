require 'rails_helper'

RSpec.describe Facility, :type => :model do
	before do
		5.times do
      Facility.create(name1: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, location_state: 'CO', location_zip: Faker::Address.zip, location_city: Faker::Address.city, location_street1: Faker::Address.street_address, services_text1: Faker::Lorem.sentence, services_text2: Faker::Lorem.sentence, services_text3: Faker::Lorem.sentence)
		end
	end

  it 'can get a facilities services' do
  	@facility = Facility.first
  	expect(@facility.services).to include(@facility.services_text1)
  end
end
