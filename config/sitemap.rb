# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.opentherapistdirectory.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  
  add therapists_path, :priority => 1.0, :changefreq => 'hourly'  

  Therapist.find_each do |therapist|
    add therapist_path(therapist), :lastmod => therapist.updated_at
  end

  add facilities_path, :changefreq => 'yearly'

  Facility.find_each do |facility|
    add facility_path(facility)
  end

  add contact_path, :changefreq => 'weekly'
  add articles_path, :changefreq => 'hourly'
end
