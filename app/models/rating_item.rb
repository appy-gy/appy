class RatingItem < ActiveRecord::Base
  attr_accessor :vote

  belongs_to :rating
  has_many :votes, dependent: :destroy
end
