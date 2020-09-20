class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  

    def reserved_dates
       self.reservations.map do |res|
            [res.checkin, res.checkout]
      end
    end


end

