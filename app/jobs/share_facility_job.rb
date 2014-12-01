class ShareFacilityJob
  @queue = :mailer

  def self.perform(user_id, params)
  	@user     = User.find(user_id)
  	facility_id = params['facility-id']
  	@facility = Facility.find(facility_id)
  	@email    = params['email']
  	@name     = params['name']

    ShareFacilityMailer.share_email(@user, @facility, @email, @name).deliver
  end
end
