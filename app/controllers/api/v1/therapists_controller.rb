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

  def create
    therapist = Therapist.new(therapist_params)

    if therapist.save
      render status: 201, json: { therapist: therapist }
    else
      render status: 422,
             json: { therapist: { errors: therapist.errors.full_messages } }
    end
  end

  private

  def therapist_params
    params.require(:therapist).permit(:name, :description)
  end
end
