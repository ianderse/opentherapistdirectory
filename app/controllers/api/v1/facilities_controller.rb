class Api::V1::FacilitiesController < API::V1::BaseController
	respond_to :json, :xml

	def index
		respond_with Facility.all
	end

	def show
		@facility = Facility.find(params[:id])

		respond_with @facility
	end
end
