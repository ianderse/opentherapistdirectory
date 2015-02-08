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
  end

  def edit
    @therapist = Therapist.find(current_user.therapist.id)
  end

  private

  def verify_user
    if !current_user
      flash[:error] = 'Please sign-in to list your practice'
      redirect_to root_path
    elsif current_user.therapist
      redirect_to edit_therapist_path
    end
  end
end
