class AddVerifiedEmailSentToTherapists < ActiveRecord::Migration
  def change
    add_column :therapists, :verified_email_sent, :boolean, default: false
  end
end
