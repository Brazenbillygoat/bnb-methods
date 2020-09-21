class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address, :listing_type, :title, :description, :price, :neighborhood_id, presence: true

  after_destroy :change_to_guest
  before_save :change_to_host

    def reserved_dates
       self.reservations.map do |res|
            [res.checkin, res.checkout]
      end
    end

    def average_review_rating
      
      listing_ratings = self.reviews.map do |review|
        review.rating
      end
      average_rating = listing_ratings.sum.to_f / listing_ratings.length
    end


    private

    def change_to_host
      self.host.update(host: true)
    end

    def change_to_guest
      self.host.listings.empty? ? self.host.update(host: false) : self.host.update(host: true)

    end

end

