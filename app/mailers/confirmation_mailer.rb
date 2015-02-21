class ConfirmationMailer < ActionMailer::Base
  default from: "admin@opentherapistdirectory.com"

  def confirm_signup(email, name)
    @email = email
    @name = name
    mail(reply_to: 'ianderse@mac.com', to: @email, subject: "Thank You For Signing Up To Be Listed on Open Therapist Directory" )
  end
end
