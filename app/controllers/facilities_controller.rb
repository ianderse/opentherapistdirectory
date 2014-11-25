class FacilitiesController < ApplicationController
	respond_to :html, :json

	def index
		@facilities = Facility.all.to_json.html_safe
		@states     = Facility.all.pluck(:location_state).uniq.sort
		respond_with(@facilities)
		# @facilities = Resque.enqueue(FacilityLoadJob)
	end

	def show
		@facility = Facility.find(params[:id])
		respond_with(@facility)
	end

	def save_facility
		if !current_user
			flash[:notice] = "Please Log-in to save facilities."
		end
		respond_to do |format|
			if !current_user.saved_facilities.include?(params[:id])
			 	current_user.saved_facilities << params[:id]
			 	current_user.save!
			end
     	format.js{render layout: false}
   	end
	end
end
