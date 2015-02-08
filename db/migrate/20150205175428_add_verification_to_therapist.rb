class AddVerificationToTherapist < ActiveRecord::Migration
  def change
    add_column :therapists, :verified, :boolean, default: false
  end
end
