class TherapistsController < ApplicationController
  before_action :verify_user, only: [:new, :edit]

	def index
    @states     ||= Therapist.includes(:location).pluck(:state).uniq.sort
    @therapists = Therapist.where(verified: true)
	end

  def show
    @therapist = Therapist.find(params[:id])
  end

  def new
    @therapist = Therapist.new
    @therapist.build_location
  end

  def edit
    @therapist = Therapist.find(current_user.therapist.id)
  end

  def create
    @therapist = Therapist.new(therapist_params)
    if @therapist.save
      flash[:notice] = "Thank you for Submitting your Practice"
      redirect_to root_path
    else
      flash[:errors] = @therapist.errors.full_messages
      render 'new'
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
                                      location_attributes: [:id, :street_1, :street_2, :city, :state, :zipcode, :phone])
  end

  def verify_user
    if !current_user
      flash[:error] = 'Please sign-in to list your practice'
      redirect_to root_path
    elsif current_user.therapist
      redirect_to edit_therapist_path
    end
  end
end
