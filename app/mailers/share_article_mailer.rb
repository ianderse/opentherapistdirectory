class ShareArticleMailer < ActionMailer::Base
  default from: "admin@opentherapistdirectory.com"

  def share_email(user, email, name, title, url)
    @user = user
    @email = email
    @name  = name
    @title = title
    @url   = url

    mail(to: @email, subject: "#{@user.name} Has Shared an Article with You" )
  end
end
