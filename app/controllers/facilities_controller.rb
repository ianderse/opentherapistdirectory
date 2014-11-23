class FacilitiesController < ApplicationController

	def index
		@facilities = Facility.all.to_json.html_safe
		@states     = Facility.all.pluck(:location_state).uniq.sort
		# @facilities = Resque.enqueue(FacilityLoadJob)
	end

	def show
		@facility = Facility.find(params[:id])
	end

	def save_facility
		respond_to do |format|
     format.js{render layout: false}
   	end
	end
end
