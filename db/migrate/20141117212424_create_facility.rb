class CreateFacility < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
    	t.string :name_1
    	t.string :name_2
    	t.string :website
    	t.string :phone
    	t.string :intake_phone
    	t.text   :services_1
    	t.text   :services_2
    	t.text   :services_3
    	t.text   :services_4
    	t.text   :services_5
    	t.text   :services_6
    	t.text   :services_7

    	t.timestamps
    end
  end
end
