class VerifySignupJob
  @queue = :mailer

  def self.perform(params)
    @therapist = Therapist.find(params)
    ConfirmationMailer.verify_signup(@therapist.email, @therapist.full_name).deliver
  end
end
