class Facility < ActiveRecord::Base
  require 'csv'
  has_one :facility_address

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
