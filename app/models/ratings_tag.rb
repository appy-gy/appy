class RatingsTag < ActiveRecord::Base
  belongs_to :rating
  belongs_to :tag, counter_cache: :ratings_count

  validates :rating, :tag, presence: true
  validates :tag, uniqueness: { scope: :rating }

  scope :about, -> tag { where tag: tag }
end
