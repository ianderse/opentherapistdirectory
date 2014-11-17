class Facility < ActiveRecord::Base
  require 'csv'
  has_one :facility_address

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      facility_hash = row.to_hash # exclude the price field
      facility = Facility.where(name1: facility_hash["name1"])

      if facility.count == 1
        facility.first.update_attributes(product_hash)
      else
        Facility.create!(product_hash)
      end
    end
  end

  # def self.import(file)
  #   (2..10).each do |i|
  #     @facilities = csv_handler(file).collect {|params| new_facility(params)}
  #     row = Hash[[header, spreadsheet.row(i)].transpose]
  #     product = find_by_id(row["id"]) || new
  #     product.attributes = row.to_hash.slice(*accessible_attributes)
  #     product.save!
  #   end

  # end

  # def self.new_facility(params)

  # end

  # private

  # def self.csv_handler(file)
  #   CSV.open(file, headers: true, header_converters: :symbol)
  # end
end
