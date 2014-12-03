class Api::V1::TherapistsController < API::V1::BaseController
	before_filter :set_format
	respond_to :json

	def set_format
	  request.format = 'json'
	end

	def index
		respond_with Therapist.all
	end

	def show
		@therapist = Therapist.find(params[:id])

		respond_with @therapist
	end
end
