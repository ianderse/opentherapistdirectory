class Admin::TherapistsController < Admin::BaseController
  def index
    @therapists = Therapist.all
  end

  def show
    @therapist = Therapist.find(params[:id])
  end
end
