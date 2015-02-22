class UsersController < ApplicationController
	def show
		if current_user.is_a?(User)
			@user = User.find(current_user.id)
			@saved_facilities = @user.saved_facilities.map do |id|
				Facility.find(id)
			end
      @saved_therapists = @user.saved_therapists.map do |id|
        Therapist.find(id)
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

  def remove_therapist
    current_user.saved_therapists.delete(params[:id])
    current_user.save
    @therapist_id = params[:id]

    respond_to do |format|
      format.js { @therapist_id }
    end
  end
end
