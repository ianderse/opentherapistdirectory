class Therapist < ActiveRecord::Base
	belongs_to :user
  has_one    :location

  def full_name
    "#{first_name} #{last_name}"
  end
end
