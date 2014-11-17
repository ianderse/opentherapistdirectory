class Admin::FacilitiesController < Admin::BaseController
	def index

	end

	def import
		flash[:notice] = "Test complete"
		redirect_to root_path
	  # Product.import(params[:file])
	  # redirect_to root_url, flash[:notice] "Products imported."
	end
end
