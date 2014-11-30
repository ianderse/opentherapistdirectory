class ShareArticleJob
  @queue = :mailer

  def self.perform(user_id, passed_params)
  	@user  = User.find(user_id)
  	@email = passed_params[:email]
    @name  = passed_params[:name]
    @title = passed_params[:article_title]
    @url   = passed_params[:article_url]

    ShareArticleMailer.share_email(@user, @email, @name, @title, @url).deliver
  end
end
