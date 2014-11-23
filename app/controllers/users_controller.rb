class UsersController < ApplicationController
	def show
		@user = User.find(current_user)
		@saved_facilities = @user.saved_facilities.map do |id|
			Facility.find(id)
		end
	end
end
