class Admin::BaseController < ApplicationController
  before_action :authorize_admin

  def authorize_admin
    if current_user.nil? || current_user.role != 'admin'
      redirect_to root_path
    end
  end

end
