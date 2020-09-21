class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address, :listing_type, :title, :description, :price, :neighborhood_id, presence: true

  # before_destroy :change_to_guest
  # before_save :change_to_host

    def reserved_dates
       self.reservations.map do |res|
            [res.checkin, res.checkout]
      end
    end


    private

    def change_to_host
      self.host = true
    end

    def change_to_guest
      self.host.listings.empty? ? self.host.host = false : self.host.host = true

    end

end

