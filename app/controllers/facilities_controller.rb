class FacilitiesController < ApplicationController

	def index
		@facilities = Facility.limit(20).to_json.html_safe
		@states     = Facility.all.pluck(:location_state).uniq.sort
		# @facilities = Resque.enqueue(FacilityLoadJob)
	end

	def show
		@facility = Facility.find(params[:id])
	end

	def save_facility
		respond_to do |format|
			if !current_user.saved_facilities.include?(params[:id])
			 	current_user.saved_facilities << params[:id]
			 	current_user.save!
			end
     	format.js{render layout: false}
   	end
	end
end
