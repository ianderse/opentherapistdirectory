class Api::V1::FacilitiesController < API::V1::BaseController
	respond_to :json

	def index
		render json: { facility: all_formatted }
	end

	def show
		@facility = Facility.find(params[:id])

		render json: { facility: format_facility(@facility) }
	end

  private

  def all_formatted
    Facility.all.map do |facility|
      returned_facility(facility)
    end
  end

  def format_facility(facility)
    returned_facility(facility)
  end

  def returned_facility(facility)
    {
      'id' => facility.id,
      'name' => facility.name1,
      'website' => facility.website,
      'phone' => facility.phone,
      'intake' => facility.intake1,
      'hotline' => facility.hotline1,
      'address' => "#{facility.location_street1} #{facility.location_street2}, #{facility.location_city}, #{facility.location_state} #{facility.location_zip}",
      'services' => facility.json_services
    }
  end



end
