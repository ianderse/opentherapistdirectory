require 'rails_helper'

RSpec.describe Api::V1::FacilitiesController, :type => :controller do
	describe "Open Therapist Directory API" do

    it "renders the facilities index as JSON" do
      5.times do
        Facility.create(name1: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, location_state: 'CO', location_zip: Faker::Address.zip, location_city: Faker::Address.city, location_street1: Faker::Address.street_address, services_text1: Faker::Lorem.sentence, services_text2: Faker::Lorem.sentence, services_text3: Faker::Lorem.sentence)
      end

      get :index, format: :json
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['facility'].length).to eq(5)
    end

    # it 'renders a specific facility as JSON' do
    #   get :show, format: :json
    #   expect(response).to be_success
    # end
  end
end
