require 'rails_helper'

RSpec.describe Api::V1::FacilitiesController, :type => :controller do
	describe "GET index" do
		# before do
		# 	5.times do
	 #      Facility.create(name1: Faker::Company.name, phone: Faker::PhoneNumber.phone_number, location_state: 'CO', location_zip: Faker::Address.zip, location_city: Faker::Address.city, location_street1: Faker::Address.street_address, services_text1: Faker::Lorem.sentence, services_text2: Faker::Lorem.sentence, services_text3: Faker::Lorem.sentence)
		# 	end
		# end

    # it "assigns @teams" do
    #   team = Team.create
    #   get :index
    #   expect(assigns(:teams)).to eq([team])
    # end

    it "renders the index template" do
    	pending
      get :index
      expect(response).to render_template("index")
    end
  end
end
