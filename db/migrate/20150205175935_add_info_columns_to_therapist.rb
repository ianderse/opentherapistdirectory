class AddInfoColumnsToTherapist < ActiveRecord::Migration
  def change
    add_column :therapists, :email, :string
    add_column :therapists, :certifications, :string
    add_column :therapists, :sliding_scale, :boolean
    add_column :therapists, :cost, :string
  end
end
