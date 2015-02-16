class AddAttachmentPictureToTherapists < ActiveRecord::Migration
  def self.up
    change_table :therapists do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :therapists, :picture
  end
end
