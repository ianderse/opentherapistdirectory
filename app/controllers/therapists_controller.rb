class TherapistsController < ApplicationController
	def index
    @states     ||= Therapist.all.pluck(:state).uniq.sort
    @therapists = Therapist.all
	end

  def show
    @therapist = Therapist.find(params[:id])
  end
end
