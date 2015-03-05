class Facility < ActiveRecord::Base
  require 'csv'

  def address
    "#{location_street1} #{location_street2}, #{location_city}, #{location_state} #{location_zip}"
  end

  def website?
    if website
      website
    else
      "None Provided"
    end
  end

  def intake
    if intake1
      intake1
    elsif intake2
      intake2
    else
      "None Provided"
    end
  end

  def hotline
    if hotline1
      hotline1
    elsif hotline2
      hotline2
    else
      "None Provided"
    end
  end

  def services
    ("<li>" + self.services_text1.to_s + "</li><li>" + self.services_text2.to_s + "</li><li>" + self.services_text3.to_s + "</li><li>" + self.services_text4.to_s + "</li><li>" + self.services_text5.to_s + "</li><li>" + self.services_text6.to_s + "</li><li>" + self.services_text7.to_s + "</li>").gsub(/;/, "").html_safe
  end

  def json_services
    (self.services_text1.to_s + self.services_text2.to_s + self.services_text3.to_s + self.services_text4.to_s + self.services_text5.to_s + self.services_text6.to_s + self.services_text7.to_s)
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true, encoding: "iso-8859-1:UTF-8") do |row|
      facility_hash = row.to_hash

      facility = Facility.where(name1: facility_hash["name1"])

      if facility.count == 1
        facility.first.update_attributes(facility_hash)
      else
        Facility.create!(facility_hash)
      end
    end
  end

end
