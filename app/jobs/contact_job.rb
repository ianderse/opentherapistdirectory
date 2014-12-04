class ContactJob
  @queue = :mailer

  def self.perform(params)
  	@name = params['name']
  	@email = params['email']
  	@content = params['content']
    ContactMailer.send_feedback(@user, @email, @name, @content).deliver
  end
end
