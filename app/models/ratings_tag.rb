class RatingsTag < ActiveRecord::Base
  belongs_to :rating
  belongs_to :tag

  validates :rating, :tag, presence: true
  validates :tag, uniqueness: { scope: :rating }
end
