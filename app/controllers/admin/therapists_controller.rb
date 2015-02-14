class Admin::TherapistsController < Admin::BaseController
  def index
    @therapists = Therapist.order('id')
  end

  def show
    @therapist = Therapist.find(params[:id])
  end

  def toggle
    if params[:verified]
      toggle_verified
    elsif params[:active]
      toggle_active
    end
  end

  def toggle_verified
    @therapist = Therapist.find(params[:id])

    if @therapist.update_attributes(:verified => params[:verified])
      render :nothing => true
    else
      flash[:errors] = 'Could Not Update Attribute'
      redirect_to admin_dashboard_path
    end
  end

  def toggle_active
    @therapist = Therapist.find(params[:id])

    if @therapist.update_attributes(:active => params[:active])
      render :nothing => true
    else
      flash[:errors] = 'Could Not Update Attribute'
      redirect_to admin_dashboard_path
    end
  end
end
