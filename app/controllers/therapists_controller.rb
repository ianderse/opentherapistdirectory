class TherapistsController < ApplicationController
  before_action :verify_user, only: [:new]

	def index
    @states     ||= Therapist.includes(:location).pluck(:state).uniq.sort
    @therapists = Therapist.where(verified: true)
	end

  def show
    @therapist = Therapist.find(params[:id])
  end

  def new

  end

  private

  def verify_user
    if !current_user
      flash[:error] = 'Please sign-in to list your practice'
      redirect_to root_path
    end
  end
end
