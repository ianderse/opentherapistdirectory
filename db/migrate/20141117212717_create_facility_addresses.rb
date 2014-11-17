class CreateFacilityAddresses < ActiveRecord::Migration
  def change
    create_table :facility_addresses do |t|
    	t.string :mail_street_1
    	t.string :mail_street_2
    	t.string :mail_city
    	t.string :mail_state
    	t.string :mail_zip
    	t.string :mail_zip_2
    	t.string :location_street_1
    	t.string :location_street_2
    	t.string :location_city
    	t.string :location_state
    	t.string :location_zip
    	t.string :location_zip_2

      t.references :facility, index: true

      t.timestamps
    end
  end
end
