class ConfirmSignupJob
  @queue = :mailer

  def self.perform(params)
    @therapist = Therapist.find(params)
    ConfirmationMailer.confirm_signup(@therapist.email, @therapist.full_name).deliver
  end
end
