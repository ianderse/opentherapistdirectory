class UsersController < ApplicationController
	def show
		@user = User.find(current_user)
		@saved_facilities = @user.saved_facilities.map do |id|
			Facility.find(id)
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
