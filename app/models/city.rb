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

    ratio_hash = {}
    cities = self.group(:name)


    cities.each do |city|
      count = 0
      listings = city.listings

      reservation_count = listings.map do |listing|
        listing.reserved_dates.count
      end

      if reservation_count[count] == 0 || city.listings.count == 0
        next
      else
        ratio_hash[city] = (city.listings.count / reservation_count[count])
      end
      
      count += 1
    end
    ratio_hash.max_by{ |k, v| v }[0]
  end
      
   


end

