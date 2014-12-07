class Tag < ActiveRecord::Base
  has_many :ratings_tags, dependent: :destroy
  has_many :ratings, through: :ratings_tags

  validates :name, presence: true, uniqueness: true
end
