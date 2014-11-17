class CreateFacility < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
    	t.string :name1
    	t.string :name2
    	t.string :website
    	t.string :phone
    	t.string :intake_phone
    	t.text   :services_text1
    	t.text   :services_text2
    	t.text   :services_text3
    	t.text   :services_text4
    	t.text   :services_text5
    	t.text   :services_text6
    	t.text   :services_text7

    	t.timestamps
    end
  end
end
