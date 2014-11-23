class FacilityLoadJob
  @queue = :create

  def self.perform
  	Facility.all.to_json.html_safe
  end
end
