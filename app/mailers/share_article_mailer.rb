class ShareArticleMailer < ActionMailer::Base
  default from: "admin@opentherapistdirectory.com"

  def share_email(user, email, name, title, url)
    @user = user
    # @email         = params.email
    # @name          = params.name
    # @article_title = params.article_title
    # @article_url   = params.article_url
    mail(to: @email, subject: "<%= @user.name %> Has Shared an Article with You" )
  end
end
