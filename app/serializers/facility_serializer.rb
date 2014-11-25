class FacilitySerializer < ActiveModel::Serializer
  attributes :id, :name1, :website, :phone, :intake1, :intake2, :mail_street1, :mail_street2, :mail_city, :mail_state, :mail_zip, :location_street1, :location_street2, :location_city, :location_state, :location_zip, :services
  # has_many

  def services
  	(object.services_text1.to_s + object.services_text2.to_s + object.services_text3.to_s + object.services_text4.to_s + object.services_text5.to_s + object.services_text6.to_s + object.services_text7.to_s).gsub(/;/, ".")
  end
end
