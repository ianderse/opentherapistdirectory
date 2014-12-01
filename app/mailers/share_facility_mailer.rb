class ShareFacilityMailer < ActionMailer::Base
  default from: "admin@opentherapistdirectory.com"

  def share_email(user, facility, email, name)
    @user = user
    @facility = facility
    @email = email
    @name  = name

    mail(to: @email, subject: "#{@user.name} Has Shared a Link With You" )
  end
end
