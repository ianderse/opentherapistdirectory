class AddPracticeNameToTherapist < ActiveRecord::Migration
  def change
    add_column :therapists, :practice_name, :string
  end
end
