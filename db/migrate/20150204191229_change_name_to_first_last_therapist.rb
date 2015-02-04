class ChangeNameToFirstLastTherapist < ActiveRecord::Migration
  def change
    remove_column :therapists, :name
    add_column :therapists, :first_name, :string
    add_column :therapists, :last_name, :string
  end
end
