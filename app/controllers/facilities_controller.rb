class FacilitiesController < ApplicationController
	respond_to :html

	def index
		if !params[:facilities].nil?
			@state = params[:facilities][:params]
		else
			@state = 'AK'
		end
		if @state.length > 2
			@state = StateHelper.us_states[@state.capitalize]
		end
		@first_facilities = Facility.where(location_state: @state.upcase).to_json.html_safe
		@facilities = Facility.all.to_json.html_safe
		@states     = Facility.all.pluck(:location_state).uniq.sort
		@initial_state = @state.upcase.to_json.html_safe
		# @facilities = Resque.enqueue(FacilityLoadJob)
	end

	def show
		@facility = Facility.find(params[:id])
	end

	def share_facility
		@facility = Facility.find(params[:id])
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

	def share
		# raise params.inspect
		passed_params = {:facility_id => params[:facility_id], :name => params[:name], :email => params[:email]}
		# raise passed_params.inspect
		Resque.enqueue(ShareFacilityJob, current_user.id, passed_params)
		redirect_to facility_path(params[:facility_id]), notice: "This Facility has been shared successfully"
	end
end
