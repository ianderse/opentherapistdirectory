class AddSavedFacilitiesToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :saved_facilities, :text
  end
end
