class CreateLocation < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :therapist
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :street_1
      t.string :street_2
    end
  end
end
