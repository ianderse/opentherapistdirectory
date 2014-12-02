require 'spec_helper'

describe ShareFacilityMailer do
  describe 'email' do
    let(:user) { User.create(name: "Test User") }
    let(:facility) { Facility.create(name1: "Test Facility") }
    email = "test@example.com"
    name  = "Test User Two"

    let(:mail) { ShareFacilityMailer.share_email(user, facility, email, name) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Test User Has Shared a Link With You')
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
  end
end
