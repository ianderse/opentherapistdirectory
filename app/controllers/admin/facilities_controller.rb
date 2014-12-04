class Admin::FacilitiesController < Admin::BaseController
	def index

	end

	def import
	  Facility.import(params[:file])
	  redirect_to root_url
	end
end
