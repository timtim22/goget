class Job < ApplicationRecord

  validates :pickup_address, presence: true
  validates :pick_lat, presence: true
  validates :pick_lng, presence: true
  validates :drop_address, presence: true
  validates :drop_lat, presence: true
  validates :drop_lng, presence: true

  belongs_to :user
end
