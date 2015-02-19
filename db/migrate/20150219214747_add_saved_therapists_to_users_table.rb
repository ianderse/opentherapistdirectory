class AddSavedTherapistsToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :saved_therapists, :text
  end
end
