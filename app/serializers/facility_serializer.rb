class FacilitySerializer < ActiveModel::Serializer
  attributes :id, :name1, :website, :phone, :intake1, :intake2, :mail_street1, :mail_street2, :mail_city, :mail_state, :mail_zip, :location_street1, :location_street2, :location_city, :location_state, :location_zip, :services
  # has_many

  def services
  	(object.services_text1 + object.services_text2 + object.services_text3 + object.services_text4 + object.services_text5 + object.services_text6 + object.services_text7).gsub(/;/, ".")
  end
end
