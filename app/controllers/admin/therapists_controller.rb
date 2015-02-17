class Admin::TherapistsController < Admin::BaseController
  def index
    @therapists = Therapist.order('id')
  end

  def show
    @therapist = Therapist.find(params[:id])
  end

  def toggle
    if params[:verified]
      toggle_attribute('verified')
    elsif params[:active]
      toggle_attribute('active')
    end
  end

  def toggle_attribute(attribute)
    attr_sym = attribute.to_sym
    @therapist = Therapist.find(params[:id])
    if @therapist.update_attributes(attr_sym => params[attr_sym])
      render :nothing => true
    else
      flash[:errors] = 'Could Not Update Attribute'
      redirect_to admin_dashboard_path
    end
  end
end
