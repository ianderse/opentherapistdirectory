class Therapist < ActiveRecord::Base
	belongs_to :user
  has_one    :location
  accepts_nested_attributes_for :location
  validates :first_name, :last_name, :email, :certifications, :cost, presence: true

  has_attached_file :picture, :styles => { :medium => "400x400#", :thumb => "150x150#" }
  validates_attachment :picture, :presence => true,
                       :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
                       :size => { :less_than => 2.megabytes }

  def full_name
    "#{first_name} #{last_name}"
  end

  def picture_url
    picture.url(:thumb)
  end

  def trunc_desc
    description.truncate(210)
  end

  def phone
    ActiveSupport::NumberHelper.number_to_phone(location.phone, area_code: true)
  end
end
