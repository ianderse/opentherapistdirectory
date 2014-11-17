class CreateFacility < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
    	t.string :name1
    	t.string :name2
    	t.string :website
    	t.string :phone
    	t.string :intake1
        t.string :intake2
        t.string :hotline1
        t.string :hotline2
        t.string :service_codes
    	t.text   :services_text1
    	t.text   :services_text2
    	t.text   :services_text3
    	t.text   :services_text4
    	t.text   :services_text5
    	t.text   :services_text6
    	t.text   :services_text7
        t.string :mail_street1
        t.string :mail_street2
        t.string :mail_city
        t.string :mail_state
        t.string :mail_zip
        t.string :mail_zip4
        t.string :location_street1
        t.string :location_street2
        t.string :location_city
        t.string :location_state
        t.string :location_zip
        t.string :location_zip4

    	t.timestamps
    end
  end
end
