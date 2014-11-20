class FacilitiesController < ApplicationController
	# caches_page :index

	def index
		@facilities = Facility.all.to_json.html_safe
		@states     = Facility.all.pluck(:location_state).uniq.sort
	end
end
