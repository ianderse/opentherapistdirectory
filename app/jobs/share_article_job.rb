class ShareArticleJob
  @queue = :mailer

  def self.perform(user_id, params)
  	@user  = User.find(user_id)
  	@email = params['email']
    @name  = params['name']
    @title = params['title']
    @url   = params['url']

    ShareArticleMailer.share_email(@user, @email, @name, @title, @url).deliver
  end
end
