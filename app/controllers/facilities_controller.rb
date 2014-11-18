class FacilitiesController < ApplicationController
	def index
		@states     = Facility.pluck(:location_state).uniq.sort
		@facilities = Facility.all
	end
end
