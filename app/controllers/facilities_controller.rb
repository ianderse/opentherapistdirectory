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
    all_facilities = Facility.all
		@first_facilities = all_facilities.find_all{|facility| facility.location_state == @state.upcase}.to_json.html_safe
		@facilities = all_facilities.to_json.html_safe
		@states     = all_facilities.pluck(:location_state).uniq.sort
		@initial_state = @state.upcase.to_json.html_safe
	end

	def show
		@facility = Facility.find(params[:id])
	end

	def share_facility
		if !current_user
			redirect_to facilities_path, alert: "Please sign-in to share facilities"
		end
		@facility = Facility.find(params[:id])
	end

	def save_facility
		if current_user
  		respond_to do |format|
  			if !current_user.saved_facilities.include?(params[:id])
  			 	current_user.saved_facilities << params[:id]
  			 	current_user.save!
  			end
       	format.js{render layout: false}
     	end
    end
	end

	def share
		passed_params = {:facility_id => params[:facility_id], :name => params[:name], :email => params[:email]}
		Resque.enqueue(ShareFacilityJob, current_user.id, passed_params)
		redirect_to facility_path(params[:facility_id]), notice: "This Facility has been shared successfully"
	end
end
