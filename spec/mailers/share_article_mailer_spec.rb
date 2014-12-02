require 'spec_helper'

describe ShareArticleMailer do
  describe 'email' do
    let(:user) { User.create(name: "Test User") }
    email = "test@example.com"
    name  = "Test User Two"
    title = "Test Article"
    url   = "http://www.example.com/"
    let(:mail) { ShareArticleMailer.share_email(user, email, name, title, url) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Test User Has Shared an Article with You')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['admin@opentherapistdirectory.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(user.name)
    end

    it 'assigns @url' do
      expect(mail.body.encoded).to match(url)
    end
  end
end
