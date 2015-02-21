class AddWebsiteToTherapists < ActiveRecord::Migration
  def change
    add_column :therapists, :website, :string
  end
end
