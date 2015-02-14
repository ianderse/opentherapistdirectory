class AddActiveColumnToTherapist < ActiveRecord::Migration
  def change
    add_column :therapists, :active, :boolean, default: false
  end
end
