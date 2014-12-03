class UsersController < ApplicationController
	def show
		if current_user
			@user = User.find(current_user)
			@saved_facilities = @user.saved_facilities.map do |id|
				Facility.find(id)
			end
		else
			flash[:alert] = "Please sign in first"
			redirect_to root_path
		end
	end

	def remove_facility
		current_user.saved_facilities.delete(params[:id])
		current_user.save
		@facility_id = params[:id]

		respond_to do |format|
      format.js { @facility_id }
    end
	end
end
