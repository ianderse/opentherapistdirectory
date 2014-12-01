class HomeController < ApplicationController
	def index

	end

	def contact

	end

	def send_contact
		passed_params = {:name => params[:name], :email => params[:email], :content => params[:content]}
		Resque.enqueue(ContactJob, current_user.id, passed_params)
		redirect_to root_path, notice: "Thanks for your feedback!"
	end
end
