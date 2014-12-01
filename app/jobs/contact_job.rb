class ContactJob
  @queue = :mailer

  def self.perform(user_id, params)
  	@user  = User.find(user_id)
  	@name = params['name']
  	@email = params['email']
  	@content = params['content']
    ContactMailer.send_feedback(@user, @email, @name, @content).deliver
  end
end
