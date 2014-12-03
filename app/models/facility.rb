class Facility < ActiveRecord::Base
  require 'csv'

  def services
    ("<li>" + self.services_text1.to_s + "</li><li>" + self.services_text2.to_s + "</li><li>" + self.services_text3.to_s + "</li><li>" + self.services_text4.to_s + "</li><li>" + self.services_text5.to_s + "</li><li>" + self.services_text6.to_s + "</li><li>" + self.services_text7.to_s + "</li>").gsub(/;/, "").html_safe
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
