class Location < ActiveRecord::Base
  belongs_to    :therapist
  validates  :phone, :zipcode, :state, :city, :street_1, presence: true

  before_save { |location| location.phone = location.convert_phone }

  def convert_phone
    phone.tr('^0-9', '')
  end
end
