class FacilitiesController < ApplicationController

	def index
		@facilities = Facility.all.to_json.html_safe
		@states     = Facility.all.pluck(:location_state).uniq.sort
	end

	def show
		@facility = Facility.find(params[:id])
	end
end
