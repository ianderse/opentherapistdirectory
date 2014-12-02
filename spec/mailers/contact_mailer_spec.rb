require 'spec_helper'

describe ContactMailer do
  describe 'email' do
    let(:user) { User.create(name: "Test User") }
    email = "test@example.com"
    name  = "Test User Two"
    title = "Test Article"
    content = 'Feedback Feeback feeeeedback'
    let(:mail) { ContactMailer.send_feedback(user, email, name, content) }

    it 'renders the subject' do
      expect(mail.subject).to eql("Feedback from Test User Two")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql(['ianderse@mac.com'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['admin@opentherapistdirectory.com'])
    end

    it 'renders the reply_to' do
      expect(mail.reply_to).to eql(['test@example.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(user.name)
    end

    it 'assigns @content' do
      expect(mail.body.encoded).to match(content)
    end
  end
end
