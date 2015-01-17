class Api::V1::FacilitiesController < API::V1::BaseController
	respond_to :json

	def index
		render json: { facility: all_formatted }
	end

	def show
		@facility = Facility.find(params[:id])

		render json: { facility: @facility }
	end

  private

  def all_formatted
    Facility.all.map do |facility|
      {
        'name' => facility.name1,
        'website' => facility.website,
        'phone' => facility.phone,
        'intake' => facility.intake1,
        'hotline' => facility.hotline1,
        'address' => "#{facility.location_street1} #{facility.location_street2}, #{facility.location_city}, #{facility.location_state} #{facility.location_zip}",
        'services' => services(facility),
      }
    end
  end

  def services(facility)
    (facility.services_text1.to_s + facility.services_text2.to_s + facility.services_text3.to_s + facility.services_text4.to_s + facility.services_text5.to_s + facility.services_text6.to_s + facility.services_text7.to_s)
  end

end
