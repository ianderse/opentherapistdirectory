class TherapistsController < ApplicationController
  before_action :verify_user, only: [:edit]

	def index
    @states   ||= Therapist.includes(:location).pluck(:state).uniq.sort
    all_therapists = Therapist.where(verified: true, active: true)
    # @first_therapists = all_therapists.find_all{|therapist| therapist.location.state == @states.first}.to_json.html_safe
    @therapists ||= all_therapists.to_json(:include => :location, :methods => [:picture_url, :full_name]).html_safe
    @initial_state = @states.first.upcase.to_json.html_safe
	end

  def show
    @therapist = Therapist.find(params[:id])
  end

  def new
    if !current_user
      flash[:error] = 'Please sign-in to list your practice'
      redirect_to root_path
    else
      @therapist = Therapist.new
      @therapist.build_location
    end
  end

  def edit
    @therapist = Therapist.find(params[:id])
  end

  def update
    @therapist = Therapist.find(params[:id])
    if @therapist.update_attributes(therapist_params)
      flash[:notice] = "Update Successful"
      redirect_to therapist_path(@therapist.id)
    else
      render 'edit'
    end
  end

  def create
    @therapist = Therapist.new(therapist_params)
    @therapist.user_id = current_user.id
    if @therapist.save
      flash[:notice] = "Thank you for Submitting your Practice"
      redirect_to root_path
    else
      flash[:errors] = @therapist.errors.full_messages
      render 'new'
    end
  end

  def destroy
    @therapist = Therapist.find(params[:id])
    @therapist.destroy
    redirect_to root_path
  end

  def save_therapist
    if current_user
      respond_to do |format|
        if !current_user.saved_therapists.include?(params[:id])
          current_user.saved_therapists << params[:id]
          current_user.save!
        end
        format.js{render layout: false}
      end
    end
  end

  private

  def therapist_params
    params.require(:therapist).permit(:first_name,
                                      :last_name,
                                      :email,
                                      :certifications,
                                      :sliding_scale,
                                      :cost,
                                      :practice_name,
                                      :picture,
                                      :description,
                                      location_attributes: [:id, :street_1, :street_2, :city, :state, :zipcode, :phone])
  end

  def verify_user
    therapist = Therapist.find(params[:id])
    if current_user.therapist != therapist
      redirect_to root_path
    end
  end
end
