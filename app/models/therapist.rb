class Therapist < ActiveRecord::Base
	belongs_to :user
  has_one    :location

  validates :first_name, :last_name, :email, :certifications, :cost, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
