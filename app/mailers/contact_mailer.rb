class ContactMailer < ActionMailer::Base
	default from: "admin@opentherapistdirectory.com"

  def send_feedback(user, email, name, content)
    @user = user
    @email = email
    @name  = name
    @content = content

    mail(reply_to: @email, to: 'ianderse@mac.com', subject: "Feedback from #{@name}" )
  end
end
