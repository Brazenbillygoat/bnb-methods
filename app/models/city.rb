class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods


  def city_openings(arrive, leave)
    avail_listings = []
    self.listings.each do |listing|
      all_available = listing.reserved_dates.all? do |date|
        arrive.to_date > date[1]  ||  leave.to_date < date[0]
      end
      if all_available 
        avail_listings << listing
      end
    end
    avail_listings
  end

  def self.highest_ratio_res_to_listings

  end
      # listing.neighborhood.city 
   


end

