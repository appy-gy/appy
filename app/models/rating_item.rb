class RatingItem < ActiveRecord::Base
  attr_accessor :vote

  mount_uploader :image, RatingItems::RatingItemImageUploader

  belongs_to :rating
  has_many :votes, dependent: :destroy
end
