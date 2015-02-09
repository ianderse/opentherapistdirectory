require 'rails_helper'

RSpec.describe Api::V1::TherapistsController, :type => :controller do
  describe "Open Therapist Directory API" do

    it 'renders the therapists index as JSON' do
      5.times do
        Therapist.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence, verified: true, sliding_scale: true, email: Faker::Internet.email, certifications: 'MA, LPC', cost: '$50-$100')
      end

      get :index, format: :json
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['therapists'].length).to eq(5)
    end

  end
end
