require 'rails_helper'

RSpec.describe Api::V1::TherapistsController, :type => :controller do
  describe "Open Therapist Directory API" do

    it 'renders the therapists index as JSON' do
      5.times do
        Therapist.create(name: Faker::Name.name, description: Faker::Lorem.sentence)
      end

      get :index, format: :json
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['therapists'].length).to eq(5)
    end

  end
end
