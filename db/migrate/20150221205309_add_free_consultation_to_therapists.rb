class AddFreeConsultationToTherapists < ActiveRecord::Migration
  def change
    add_column :therapists, :free_consultation, :boolean
  end
end
