class Admin::TherapistsController < Admin::BaseController
  def index
    @therapists = Therapist.order('id')
  end

  def show
    @therapist = Therapist.find(params[:id])
  end

  def toggle
    @therapist = Therapist.find(params[:id])
    if params[:verified]
      if !@therapist.verified_email_sent
        @therapist.verified_email_sent = true
        @therapist.save
        verify_signup(params[:id])
      end
      toggle_attribute('verified')
    elsif params[:active]
      toggle_attribute('active')
    end
  end

  private

  def toggle_attribute(attribute)
    attr_sym = attribute.to_sym
    @therapist = Therapist.find(params[:id])
    if @therapist.update_attributes(attr_sym => params[attr_sym])
      render :nothing => true
    else
      flash[:error] = 'Could Not Update Attribute'
      redirect_to admin_dashboard_path
    end
  end

  def verify_signup(therapist_id)
    Resque.enqueue(VerifySignupJob, therapist_id)
  end
end
