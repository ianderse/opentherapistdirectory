class Api::V1::FacilitiesController < API::V1::BaseController
	respond_to :json

	def index
		render json: { facility: Facility.all }
	end

	def show
		@facility = Facility.find(params[:id])

		render json: { facility: @facility }
	end
end
